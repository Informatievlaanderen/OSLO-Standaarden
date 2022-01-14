#!/bin/bash

ROOTDIR=$1
REPODIR=$ROOTDIR/repositories
NUXTDIR=$ROOTDIR/nuxt

mkdir -p "$NUXTDIR"

## Copy each configuration file and description file to nuxt folder
while IFS= read -r line
do
  REPO_NAME=$(echo "$line" | cut -d ":" -f 1)
  CONFIG_NAME=$(echo "$line" | cut -d ":" -f 2 | cut -d "." -f 1)

  cd "$REPODIR/$REPO_NAME"

  SPEC_NAME=$(jq -r '.naam' "$CONFIG_NAME.json")
  DESCRIPTION_NAME=$(jq -r '.beschrijving' "$CONFIG_NAME.json")

  ## Normalizing spec name to be used as directory name
  SPECIAL_CHARACTERS_REMOVED="${SPEC_NAME//[:&]/}"
  MULTI_SPACE_REMOVED="${SPECIAL_CHARACTERS_REMOVED//  /}"
  NORMALIZED_SPEC_NAME="${MULTI_SPACE_REMOVED// /-}"

  mkdir -p "$NUXTDIR/$NORMALIZED_SPEC_NAME"

  cp "$CONFIG_NAME.json" "descriptions/$DESCRIPTION_NAME" "$NUXTDIR/$NORMALIZED_SPEC_NAME"
done < "$ROOTDIR/tmp-register.txt"

## TODO: copy statistics