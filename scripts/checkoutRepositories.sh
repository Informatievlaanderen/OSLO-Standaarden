#!/bin/bash

PUBCONFIG=$2
ROOTDIR=$1
CONFIGDIR=$3

# some test calls
#jq -r '.[] | @sh "echo \(.urlref)"' publication.config | bash -e
#jq -r '.[] | @sh "./checkout-one.sh \(.)"' publication.config | bash -e

#
# create the directory layout which allows the ea-to-rdf & the
# specgenerator to do there work:
# * src/DIR: the git repository which contains the source
# * target/DIR: the generated artificats that will be committed for publication
# * report/DIR: a directory with all intermediate and log reports to
#               understand the execution trace.  Will also be
#               committed to github, but on a separate directory so
#               that it will not be served by the proxy * the
#               implementation of the see-also rules

# use of json config files is supported by the jq tool, which is per
# default available in the circleci dockers.

# the data that is used to create the directory setup should be
# integrated with the data in the cloned repository the reason for
# this is that some data such as the navigation trail is part of the
# publication section and not of the local repository

# performance consideration: the checkout & build times might increase
# rapidely as there are many publication points to handle we coudl
# consider to create a docker with the to-be-generated situation in a
# previous state and start form that one.  The build of a new docker
# should than be done on regular time (not on every commit) e.g. 1 /
# month. And then the publication would only chekcout additonal
# publicationpoints for that month. That would reduce the runtime
# drastically.

HOSTNAME=$(jq -r .hostname ${CONFIGDIR}/config.json)

cleanup_directory() {
  rm -rf .git
  rm -rf codelijsten 

  local MAPPINGFILE=`jq -r 'if (.filename | length) > 0 then .filename else @sh "config/eap-mapping.json"  end' .publication-point.json`
  if [[ -f ".names.txt" && -f $MAPPINGFILE ]]
  then
    STR=".[] | select(.name == \"$(cat .names.txt)\") | [.]"
    jq "${STR}" ${MAPPINGFILE} >.names.json
    jq -r '.[] | @sh "find . -name \"*.eap\" !  -name \(.eap) -type f -exec rm -f {} + "' .names.json | bash -e
    SITE=`jq -r .[].site .names.json`
    find ./site-skeleton -depth -type d ! -wholename "./site-skeleton"  ! -wholename "./${SITE}" -exec rm -rf {} + 
  fi
}

git_download() {
     local GITTARGETDIR=$1

     REPO=$(_jq '.repository')
     REPO=`echo ${REPO} | sed -e "s|https://||g" | sed -e "s|/|-|g"`
     GITTMPDIR="/tmp/github/${REPO}"

     if [ ! -d ${GITTMPDIR} ] ; then
        git clone $(_jq '.repository') ${GITTMPDIR}
     fi
     pushd ${GITTMPDIR}

     if ! git checkout $(_jq '.branchtag')
     then
        # branch could not be checked out for some reason
        echo "failed: $ROOTDIR/$MAIN/$RDIR $(_jq '.branchtag')" >>$ROOTDIR/failed.txt
     fi
     cp -a ${GITTMPDIR}/. ${GITTARGETDIR}

     popd
}


toolchainhash=$(git log | grep commit | head -1 | cut -d " " -f 2)

# Process the publications.config file
if cat ${PUBCONFIG} | jq -e . >/dev/null 2>&1
then
  # only iterate over those that have a repository
  for row in $(jq -r '.[] | select(.repository)  | @base64 ' ${PUBCONFIG}); do
    _jq() {
      echo ${row} | base64 --decode | jq -r ${1}
    }

      FORM=$(_jq '.type')
      if [ "$FORM" == "raw" ]
      then
        MAIN=raw-input
      else
        MAIN=src
      fi

      echo "start processing (repository): $(_jq '.repository') $(_jq '.urlref') $MAIN"

      DIR=$(_jq '.urlref')
      NAME=$(_jq '.name')
      RDIR=${DIR#'/'}
      mkdir -p $ROOTDIR/$MAIN/$RDIR
      mkdir -p $ROOTDIR/target/$RDIR
      mkdir -p $ROOTDIR/report/$RDIR

      git_download $ROOTDIR/$MAIN/$RDIR
#      git clone $(_jq '.repository') $ROOTDIR/$MAIN/$RDIR
#
#      pushd $ROOTDIR/$MAIN/$RDIR
#      if ! git checkout $(_jq '.branchtag')
#      then
#        # branch could not be checked out for some reason
#        echo "failed: $ROOTDIR/$MAIN/$RDIR $(_jq '.branchtag')" >>$ROOTDIR/failed.txt
#      fi

      pushd $ROOTDIR/$MAIN/$RDIR

      # Save the Name points to be processed
      if [[ ! -z "$NAME" && "$NAME" != "null" ]]
      then
        echo "check name $NAME is present"
        echo "$NAME" >>.names.txt
      fi
      comhash=$(git log | grep commit | head -1 | cut -d " " -f 2)
      echo "hashcode to add: ${comhash}"
      echo ${row} | base64 --decode | jq --arg comhash "${comhash}" --arg toolchainhash "${toolchainhash}" --arg hostname "${HOSTNAME}" '. + {documentcommit : $comhash, toolchaincommit: $toolchainhash, hostname: $hostname }' > .publication-point.json
      cleanup_directory
      popd

      if [[ "$MAIN" == "src" ]]
      then
        echo "$RDIR" >>$ROOTDIR/checkouts.txt
      elif [[ "$MAIN" == "raw-input" ]]
      then
        echo "force removal of .git directory - $ROOTDIR/$MAIN/$RDIR"
        echo "$RDIR" >>$ROOTDIR/rawcheckouts.txt
        cat $ROOTDIR/rawcheckouts.txt
        rm -rf $ROOTDIR/$MAIN/$RDIR/.git
        localdirectory=$(_jq '.directory')
        if [[ "$localdirectory" != "null" ]]; then
          echo "only take the content of the directory $localdirectory"
          rm -rf /tmp/rawdir /tmp/reportdir
          mkdir -p /tmp/rawdir /tmp/reportdir
          cp -r $ROOTDIR/$MAIN/$RDIR/$localdirectory/* /tmp/rawdir
          if [ -d $ROOTDIR/$MAIN/$RDIR/report/$localdirectory/ ]
          then
            cp -r $ROOTDIR/$MAIN/$RDIR/report/$localdirectory/* /tmp/reportdir
          fi
          rm -rf $ROOTDIR/$MAIN/$RDIR/*
          cp -r /tmp/rawdir/* $ROOTDIR/$MAIN/$RDIR/
          if [ "$(ls -A /tmp/reportdir)" ]
          then
            mkdir -p $ROOTDIR/$MAIN/report/$RDIR/
            cp -r /tmp/reportdir/* $ROOTDIR/$MAIN/report/$RDIR/
          fi
        else
          echo "no localdirectory defined, keep content as is"
        fi
      fi

  done


    jq '[.[] | if has("seealso") then . else empty  end ] ' ${PUBCONFIG} > $ROOTDIR/links.txt

    if [[ -f "$ROOTDIR/failed.txt" ]]
    then
    echo "failed checking out branches"
    cat $ROOTDIR/failed.txt
    exit -1
  fi
  touch $ROOTDIR/checkouts.txt
  touch $ROOTDIR/rawcheckouts.txt
else
  echo "problem in processing: ${PUBCONFIG}"
  exit -1
fi


