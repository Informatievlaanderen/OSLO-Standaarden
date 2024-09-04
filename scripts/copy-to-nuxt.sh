#!/bin/bash

ROOTDIR=$1
REPODIR=$ROOTDIR/repositories
NUXTDIR=$ROOTDIR/nuxt

# Define list of possible languages
LANGUAGES=("en" "nl" "fr" "de")
LANGUAGE_STRING=$(IFS=','; echo "${LANGUAGES[*]}")

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

  ## Translate and copy the generated configuration file and description file to the nuxt directory
  for lang in "${LANGUAGES[@]}"; do
    # Execute node script using if 
    if ! node /app/autotranslate-config.js -i "${CONFIG_NAME}.json" -m "nl" -g "${lang}" -s "${AZURETRANSLATIONKEY}"; then
        echo "Translation config: failed"
    else
        echo "Translation config: Files successfully translated"
    fi
    # Copy the translated file to the nuxt directory
    mkdir -p "$NUXTDIR/$NORMALIZED_SPEC_NAME/$lang"
    cp "${CONFIG_NAME}.json" "$NUXTDIR/$NORMALIZED_SPEC_NAME/$lang/configuration.json"
  done

  cp "descriptions/$DESCRIPTION_NAME" "$NUXTDIR/$NORMALIZED_SPEC_NAME/description.md"
  if ! node /app/autotranslate-md.js -i "$NUXTDIR/$NORMALIZED_SPEC_NAME/description.md" -m "nl" -g "$LANGUAGE_STRING" -s "${AZURETRANSLATIONKEY}" ; then
    echo "Translation md: failed"
  else
    echo "Translation md: Files succesfully translated"
  fi
  
done < "$ROOTDIR/tmp-register.txt"