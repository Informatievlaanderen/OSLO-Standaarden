#!/bin/bash

ROOT_DIR=$1
PUB_CONFIG=$2
CIRCLEWORKDIR=$3 #set explicitly because CIRCLECI_WORKING_DIRECTORY is "~/project"

CONFIG_FOLDER=${PUB_CONFIG%/*}
PUB_FILE=${PUB_CONFIG##*/}

TOOLCHAINCONFIG=${CONFIG_FOLDER}/config.json

#
# merge the publication-configuration with the versions found in the branch specific one.
# For the test branch there is a special case that merges the production and test data together.
#
# use of json config files is supported by the jq tool, which is per
# default available in the circleci dockers.

# Cleanup root (just in case)
rm -rf $ROOT_DIR/*.txt
rm -rf tmp

makeVariationsOfMergedPublicationAndCheckValidity() {
  folder=$1
  if [ $(find tmp/$folder/config -type f | wc -l) -gt 0 ]; then
    jq --slurp -S '[.[][]]' $(find tmp/$folder/config -type f) >tmp/$folder/all.json
    if [ "$?" -gt 0 ]; then
      echo "ERROR: incorrect JSON FILE: $(find tmp/$folder/config -type f)"
      exit 1
    fi
  else
    echo "WARN: no config found in tmp/$folder/config, falling back to empty list"
    mkdir -p tmp/$folder
    echo "[]" >tmp/$folder/all.json
  fi

  jq '.|=sort_by(.urlref)' tmp/$folder/all.json >tmp/$folder/publication.json
  jq ' [.[] | .urlref ]' tmp/$folder/publication.json >tmp/$folder/uri.json
  jq '[.[] | select( .disabled | not )]' tmp/$folder/publication.json | jq '.|=sort_by(.urlref)' >tmp/$folder/enabled_publication.json
  jq ' [.[] | .urlref ]' tmp/$folder/enabled_publication.json >tmp/$folder/enabled_uri.json
}

PUBLICATIONPOINTSDIRS=$(jq -r '.publicationpoints | @sh' ${CONFIG_FOLDER}/config.json)
PUBLICATIONPOINTSDIRS=$(echo ${PUBLICATIONPOINTSDIRS} | sed -e "s/'//g")

# determine the last changed files
# TOOLCHAIN_TOKEN is a PAT key configured in circleci as environment variable
mkdir -p $ROOT_DIR
GENERATEDREPO=$(jq --arg bt "${CIRCLE_BRANCH}" -r '.generatedrepository + {"filepath":"report/commit.json", "branchtag":"\($bt)"}' ${TOOLCHAINCONFIG})
./scripts/downloadFileGithub.sh "${GENERATEDREPO}" ${ROOT_DIR}/commit.json ${TOOLCHAIN_TOKEN}
sleep 5s

# calculate changesRequireBuild false if only changes in publication files that are not used
# calculate onlyChangedPublicationFiles false will trigger full rebuild
if jq -e . $ROOT_DIR/commit.json; then
  changesRequireBuild=false
  onlyChangedPublicationFiles=true

  COMMIT=$(jq -r .commit $ROOT_DIR/commit.json)

  listOfChanges=$(git diff --name-only --no-renames $COMMIT)
  echo "write change file"
  echo $listOfChanges > changes.txt

  for dir in ${PUBLICATIONPOINTSDIRS}; do
    mkdir -p tmp/prev/config/$dir
    mkdir -p tmp/next/config/$dir
  done

  GITROOT=${CONFIG_FOLDER#${CIRCLEWORKDIR}}

  # a development option to reduce the number of full rebuilds
  TRIGGERALL=$(jq -r .toolchain.triggerall ${TOOLCHAINCONFIG})

  while read -r filename; do
    filenameInSelection=false
    for dir in ${PUBLICATIONPOINTSDIRS}; do
      if [[ $filename == ${GITROOT}/$dir/*.${PUB_FILE} ]]; then
        filenameInSelection=true
      fi
      if [[ $filename == ${GITROOT}/$dir/${PUB_FILE} ]]; then
        filenameInSelection=true
      fi
    done

    if [[ $filenameInSelection == "true" ]]; then
      echo "The file $filename is added for publicationchanges"
      if git show $COMMIT:$filename &>/dev/null; then
        git show $COMMIT:$filename >tmp/prev/$filename
      fi
      if [[ -f $filename ]]; then
        cp $filename tmp/next/$filename
      fi
      changesRequireBuild=true
    elif [[ $filename == $GITROOT/*/*.$PUB_FILE || $filename == $GITROOT/*.$PUB_FILE ]]; then
      echo "The file $filename is skipped as it is not part of the current environment"
    elif [[ $filename == $GITROOT/*/$PUB_FILE || $filename == $GITROOT/$PUB_FILE ]]; then
      echo "The file $filename is skipped as it is not part of the current environment"
    elif [[ ${TRIGGERALL} == "false" ]]; then
      echo "WARNING: a full rebuild is switched off. This is an development mode only choice, changed file was: $filename"
      onlyChangedPublicationFiles=false
    else
      echo "The file $filename is not a publication, everything will need to be processed"
      changesRequireBuild=true
      onlyChangedPublicationFiles=false
    fi
  done <<<"$listOfChanges"
else
  changesRequireBuild=true
  onlyChangedPublicationFiles=false
fi

#as there are only changes in the publication files, check if there are parts that are deleted, which means a full rebuild or are it only additions
if [[ $changesRequireBuild == "true" && $onlyChangedPublicationFiles == "true" ]]; then

  makeVariationsOfMergedPublicationAndCheckValidity next
  makeVariationsOfMergedPublicationAndCheckValidity prev

  #if you want to be sure disabled are removed when removed in next version change to tmp/prev/uri.json
  jq -s '.[0] - .[1]' tmp/prev/enabled_uri.json tmp/next/uri.json >tmp/removedUri.json
  if jq -e '.[0]' tmp/removedUri.json >/dev/null 2>&1; then
    onlyChangedPublications=false
  else
    onlyChangedPublications=true
  fi
  if [[ ${TRIGGERALL} == "false" ]]; then
	echo "WARNING: a full rebuild is switched off. "
    onlyChangedPublications=true
  fi
else
  if [[ ${TRIGGERALL} == "false" ]]; then
	echo "WARNING: a full rebuild is switched off. "
	makeVariationsOfMergedPublicationAndCheckValidity next
	makeVariationsOfMergedPublicationAndCheckValidity prev
	onlyChangedPublications=true
   else 
	onlyChangedPublications=false
  fi

fi

if [[ $changesRequireBuild == "false" ]]; then
  #no changes for this environment
  echo "true" >$ROOT_DIR/haschangedpublications.json
  cp ${PUB_CONFIG} $ROOT_DIR/publications.json.old
  echo "[]" >${PUB_CONFIG}
  echo "[]" >$ROOT_DIR/changedpublications.json
  echo "kind of skip processing"
elif [[ $onlyChangedPublications == "true" ]]; then
  #only changes in publication
  echo "true" >$ROOT_DIR/haschangedpublications.json
  cp ${PUB_CONFIG} $ROOT_DIR/publications.json.old
  jq -s '.[0] - .[1]' tmp/next/enabled_publication.json tmp/prev/enabled_publication.json >tmp/addedOrChanged.json
  cp tmp/addedOrChanged.json ${PUB_CONFIG}
  cp tmp/addedOrChanged.json $ROOT_DIR/changedpublications.json
  echo "process only added and updated publication points"
else
  echo "include all selected publication points"
  mkdir -p tmp/all/config
  for dir in ${PUBLICATIONPOINTSDIRS}; do
    mkdir -p tmp/all/config/$dir
    echo "try to copy all files with extension ${PUB_FILE}"
    cp ${CONFIG_FOLDER}/$dir/*.${PUB_FILE} tmp/all/config/$dir
    echo "try to copy file ${PUB_FILE}"
    cp ${CONFIG_FOLDER}/$dir/${PUB_FILE} tmp/all/config/$dir
  done
  echo "errors are normal if the files of the above form are not present"
  makeVariationsOfMergedPublicationAndCheckValidity all
  echo "false" >$ROOT_DIR/haschangedpublications.json
  cp ${PUB_CONFIG} $ROOT_DIR/publications.json.old
  cp tmp/all/enabled_publication.json ${PUB_CONFIG}
  cp tmp/all/enabled_publication.json $ROOT_DIR/changedpublications.json
  echo "process all publication points"
fi
