#!/bin/bash

ROOTDIR=$1
REPODIR=$ROOTDIR/repositories
NUXTDIR=$ROOTDIR/content/standaarden

mkdir -p "$NUXTDIR"

## Copy each configuration file and description file to content/standaarden folder
while IFS= read -r line
do
  REPO_NAME=$(echo "$line" | cut -d ":" -f 1)
  CONFIG_NAME=$(echo "$line" | cut -d ":" -f 2 | cut -d "." -f 1)

  cd "$REPODIR/$REPO_NAME"

  SPEC_NAME=$(jq -r '.title' "$CONFIG_NAME.json")
  DESCRIPTION_NAME=$(jq -r '.beschrijving' "$CONFIG_NAME.json")

  ## Normalizing spec name to be used as directory name
  NORMALIZED_SPEC_NAME="$(echo $SPEC_NAME | tr -c '[:alnum:]\n\r' '-' | tr -s '-' | tr '[:upper:]' '[:lower:]')"

  mkdir -p "$NUXTDIR/$NORMALIZED_SPEC_NAME"

  ## Copy the generated configuration file and description file to the nuxt directory
  cp "$CONFIG_NAME.json" "$NUXTDIR/$NORMALIZED_SPEC_NAME/configuration.json"
  cp "descriptions/$DESCRIPTION_NAME" "$NUXTDIR/$NORMALIZED_SPEC_NAME/description.md"
done < "$ROOTDIR/tmp-register.txt"