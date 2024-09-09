#!/bin/bash

ROOTDIR=$1
REPODIR=$ROOTDIR/repositories
NUXTDIR=$ROOTDIR/nuxt


CONFIGDIR_DEFAULT=$( eval echo "${CIRCLE_WORKING_DIRECTORY}" )
CONFIGDIR=${2:-$CONFIGDIR_DEFAULT/config}

PRIMELANGUAGECONFIG=$(jq -r .primeLanguage ${CONFIGDIR}/config.json)
GOALLANGUAGECONFIG=$(jq -r '.otherLanguages | @sh' ${CONFIGDIR}/config.json)
GOALLANGUAGECONFIG=$(echo ${GOALLANGUAGECONFIG} | sed -e "s/'//g")

PRIMELANGUAGE=${3-${PRIMELANGUAGECONFIG}}
GOALLANGUAGE=${4-${GOALLANGUAGECONFIG}}


mkdir -p "$NUXTDIR"

echo ls -a

## Copy each configuration file and description file to content/standaarden folder
while IFS= read -r line
do
  REPO_NAME=$(echo "$line" | cut -d ":" -f 1)
  CONFIG_NAME=$(echo "$line" | cut -d ":" -f 2 | cut -d "." -f 1)

  echo "REPO_NAME: $REPO_NAME"
  echo "CONFIG_NAME: $CONFIG_NAME"

  cd "$REPODIR/$REPO_NAME"


  ## this needs to change to .title if the new json structure is used
  SPEC_NAME=$(jq -r '.title' "$CONFIG_NAME.json")
  ## this needs to change to .descriptionFileName if the new json structure is used
  DESCRIPTION_NAME=$(jq -r '.descriptionFileName' "$CONFIG_NAME.json")

  echo "SPEC_NAME: $SPEC_NAME"
  echo "DESCRIPTION_NAME: $DESCRIPTION_NAME"

  ## Normalizing spec name to be used as directory name
  NORMALIZED_SPEC_NAME="$(echo $SPEC_NAME | iconv -f utf8 -t ascii//TRANSLIT | tr -c '[:alnum:]\n\r' '-' | tr -s '-' | tr '[:upper:]' '[:lower:]')"

  echo "NORMALIZED_SPEC_NAME: $NORMALIZED_SPEC_NAME"

  mkdir -p "$NUXTDIR/$NORMALIZED_SPEC_NAME"

  # Store the repository name in the configuration file
  jq --arg REPOSITORY "$REPO_NAME" '. + {"repository": $REPOSITORY}' "$CONFIG_NAME.json" > "temp.json" && mv "temp.json" "$CONFIG_NAME.json"


  ## Copy the generated configuration file and description file to the nuxt directory

  for l in ${PRIMELANGUAGE} ; do
  node /app/node convert-config.js -i <input> -l <languagecode>'

  cp "$CONFIG_NAME.json" "$NUXTDIR/$NORMALIZED_SPEC_NAME/configuration.json"
  cp "descriptions/$DESCRIPTION_NAME" "$NUXTDIR/$NORMALIZED_SPEC_NAME/description.md"

  done 
  
done < "$ROOTDIR/tmp-register.txt"
