#!/bin/bash

ROOTDIR=$1
REPODIR=$ROOTDIR/repositories
NUXTDIR=$ROOTDIR/nuxt
NUXTMEMORYDIR=$ROOTDIR/nuxtmemory


CONFIGDIR_DEFAULT=$( eval echo "${CIRCLE_WORKING_DIRECTORY}" )
CONFIGDIR=${2:-$CONFIGDIR_DEFAULT/config}

PRIMELANGUAGECONFIG=$(jq -r .primeLanguage ${CONFIGDIR}/config.json)
GOALLANGUAGECONFIG=$(jq -r '.otherLanguages | @sh' ${CONFIGDIR}/config.json)
GOALLANGUAGECONFIG=$(echo ${GOALLANGUAGECONFIG} | sed -e "s/'//g")

PRIMELANGUAGE=${3-${PRIMELANGUAGECONFIG}}
GOALLANGUAGE=${4-${GOALLANGUAGECONFIG}}

translate_and_copy_config() {
  local CONFIGURATIONFILE=$1

  md5sum ${CONFIGURATIONFILE} > ${CONFIGMD5SUM}
  for lang in ${GOALLANGUAGE}; do
     node /app/autotranslate-config.js -i ${CONFIGURATIONFILE} -o "$CONFIG_NAME-multilang.json" -m ${PRIMELANGUAGE} -g $lang -s "$AZURETRANSLATIONKEY" >> "$ERROR_FILE"
  done
  cp "$CONFIG_NAME-multilang.json" "$NUXTDIR/$NORMALIZED_SPEC_NAME/configuration.json"
  ## Convert config file to single language and copy the generated configuration file to the nuxt directory
  for lang in ${GOALLANGUAGE}; do
    mkdir -p "$NUXTDIR/$NORMALIZED_SPEC_NAME/$lang"
    node /app/convert-config.js -i "$CONFIG_NAME-multilang.json" -l "$lang" -o "$NUXTDIR/$NORMALIZED_SPEC_NAME/$lang/configuration.json" >> "$ERROR_FILE"
  done
}

filter_error_file() { 
  local ERROR_FILE=$2
  # Check if error file exists
  if [ -f "$ERROR_FILE" ]; then
    # Check if error file is empty
    if [ -s "$ERROR_FILE" ]; then
      echo "Error file is not empty"
      # Remove lines without "failed" or "Error" in the error file
      sed -i '/failed\|Error/I!d' "$ERROR_FILE"
    else
      echo "Error file is empty"
      rm "$ERROR_FILE"
    fi
  fi

}

mkdir -p "$NUXTDIR"

echo ls -a

## Copy each configuration file and description file to content/standaarden folder
while IFS= read -r line
do
  REPO_NAME=$(echo "$line" | cut -d ":" -f 1)
  CONFIG_NAME=$(echo "$line" | cut -d ":" -f 2 | cut -d "." -f 1)
  ERROR_FILE = "$NUXTDIR/$NORMALIZED_SPEC_NAME/error.txt"

  echo "Error repo name: $REPO_NAME" > "$ERROR_FILE"

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
  NUXTMEMORYNORMALIZED_SPEC_NAME="$NUXTMEMORYDIR/$NORMALIZED_SPEC_NAME"

  echo "NORMALIZED_SPEC_NAME: $NORMALIZED_SPEC_NAME"

  mkdir -p "$NUXTDIR/$NORMALIZED_SPEC_NAME"
  CONFIGURATIONFILE=${NUXTDIR}/${NORMALIZED_SPEC_NAME}/configuration.json

  # Store the repository name in the configuration file
  jq --arg REPOSITORY "$REPO_NAME" '. + {"repository": $REPOSITORY}' "$CONFIG_NAME.json" > /tmp/temp.json 
  mv /tmp/temp.json ${CONFIGURATIONFILE}


  CONFIGMD5SUM="$NUXTMEMORYNORMALIZED_SPEC_NAME/${PRIMELANGUAGE}/configuration.json.md5sum"
  mkdir -p ${NUXTMEMORYNORMALIZED_SPEC_NAME}/${PRIMELANGUAGE}
  if [ -f "$NUXTMEMORYNORMALIZED_SPEC_NAME/${PRIMELANGUAGE}/configuration.json" ]; then
    # Check if md5sum is the same
    CURSUM=$(md5sum ${CONFIGURATIONFILE})
    OLDSUM=$(cat "$CONFIGMD5SUM")
    if [ "$CURSUM" == "$OLDSUM" ]; then
       echo "Use old configuration file"
       for lang in ${GOALLANGUAGE}; do
         cp "$NUXTMEMORYNORMALIZED_SPEC_NAME/$lang/configuration.json" "$NUXTDIR/$NORMALIZED_SPEC_NAME/$lang/configuration.json" || echo "Copy failed : cp $NUXTMEMORYNORMALIZED_SPEC_NAME/$lang/configuration.json $NUXTDIR/$NORMALIZED_SPEC_NAME/$lang/configuration.json" >> "$ERROR_FILE"
       done
    else
      translate_and_copy_config ${CONFIGURATIONFILE}
    fi
  else
    translate_and_copy_config ${CONFIGURATIONFILE}
  fi  

  # Check if the description file exists and didn't change in the memory
  DESCRIPTIONFILE=${NUXTDIR}/${NORMALIZED_SPEC_NAME}/description.md
  cp "descriptions/$DESCRIPTION_NAME" "$DESCRIPTIONFILE" || echo "Copy failed : cp descriptions/$DESCRIPTION_NAME $DESCRIPTIONFILE" >> "$ERROR_FILE"
  MD5SUMFILE="$NUXTMEMORYNORMALIZED_SPEC_NAME/${PRIMELANGUAGE}/description.md.md5sum"
  # Check if file is in memory
  if [ -f "$NUXTMEMORYNORMALIZED_SPEC_NAME/${PRIMELANGUAGE}/description.md" ]; then
    # Check if md5sum is the same
    CURSUM=$(md5sum "$DESCRIPTIONFILE")
    OLDSUM=$(cat "$MD5SUMFILE")
    if [ "$CURSUM" == "$OLDSUM" ]; then
       echo "Use old description file"
       for lang in ${GOALLANGUAGE}; do
         cp "$NUXTMEMORYNORMALIZED_SPEC_NAME/$lang/description.md" "$NUXTDIR/$NORMALIZED_SPEC_NAME/$lang/description.md" || echo "Copy failed : cp $NUXTMEMORYNORMALIZED_SPEC_NAME/$lang/description.md $NUXTDIR/$NORMALIZED_SPEC_NAME/$lang/description.md" >> "$ERROR_FILE"
       done
    else
      md5sum "$DESCRIPTIONFILE" > "$MD5SUMFILE"
       for lang in ${GOALLANGUAGE}; do
          node /app/autotranslate-md.js -i "$DESCRIPTIONFILE" -m ${PRIMELANGUAGE} -g ${lang} -s "$AZURETRANSLATIONKEY" >> "$ERROR_FILE"
     done
    fi
  else
    md5sum "$DESCRIPTIONFILE" > "$MD5SUMFILE"
       for lang in ${GOALLANGUAGE}; do
    node /app/autotranslate-md.js -i "$DESCRIPTIONFILE" -m ${PRIMELANGUAGE} -g $lang  -s "$AZURETRANSLATIONKEY" >> "$ERROR_FILE"
done
  fi

  rm "$NUXTDIR/$NORMALIZED_SPEC_NAME/description.md"

  # Copy the translations to the memory
  cp -r "$NUXTDIR/$NORMALIZED_SPEC_NAME/"* "$NUXTMEMORYNORMALIZED_SPEC_NAME" || echo "Copy failed : cp -r $NUXTDIR/$NORMALIZED_SPEC_NAME/* $NUXTMEMORYNORMALIZED_SPEC_NAME" >> "$ERROR_FILE"

  # Filter the error file
  filter_error_file "$ERROR_FILE"
  
done < "$ROOTDIR/tmp-register.txt"
