#!/bin/bash

ROOTDIR=$1
REPODIR=$ROOTDIR/repositories
NUXTDIR=$ROOTDIR/nuxt

mkdir -p "$NUXTDIR"

## Copy each configuration file and description file to nuxt folder
while IFS= read -r line
do
  REPO_NAME=$(echo "$line" | cut -d ":" -f 1)
  CONFIG_NAME="configuration"

  cd "$REPODIR/$REPO_NAME"

  SPEC_NAME=$(jq -r '.title' "$CONFIG_NAME.json")
  DESCRIPTION_NAME=$(jq -r '.beschrijving' "$CONFIG_NAME.json")

  ## Normalizing spec name to be used as directory name
  NORMALIZED_SPEC_NAME="$(echo $SPEC_NAME | tr -c '[:alnum:]\n\r' '-' | tr -s '-' | tr '[:upper:]' '[:lower:]')"

  mkdir -p "$NUXTDIR/$NORMALIZED_SPEC_NAME"

  cp "$CONFIG_NAME.json" "descriptions/$DESCRIPTION_NAME" "$NUXTDIR/$NORMALIZED_SPEC_NAME"
done < "$ROOTDIR/tmp-register.txt"