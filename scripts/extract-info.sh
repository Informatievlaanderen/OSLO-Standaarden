#!/bin/bash

ROOTDIR=$1
REPODIR=$ROOTDIR/repositories

ls "$ROOTDIR"

while IFS= read -r line
do
  REPO_NAME=$(echo "$line" | cut -d ":" -f 1)

  cd "$REPODIR/$REPO_NAME"
  CONFIG_NAME=$(echo "$line" | cut -d ":" -f 2 | cut -d "." -f 1)
  SPEC_NAME=$(jq -r '.naam' "$CONFIG_NAME.json")



  ## Extract information about the files containing the description for the detail page
  DESCRIPTION_NAME=$(jq -r '.beschrijving' "$CONFIG_NAME.json")

  echo "$CONFIG_NAME:$DESCRIPTION_NAME" >> "$ROOTDIR/description-paths.txt"

  #### Constructing file name ####
  SPECIAL_CHARACTERS_REMOVED="${SPEC_NAME//[:&]/}"
  MULTI_SPACE_REMOVED="${SPECIAL_CHARACTERS_REMOVED//  /}"
  SPACE_REPLACED="${MULTI_SPACE_REMOVED// /-}"

  echo "$CONFIG_NAME:$SPACE_REPLACED" >> "$ROOTDIR/filenames.txt"

done < "$ROOTDIR/tmp-register.txt"

echo "[extract-info.sh]: this is the output of the statistics_config.json file:"
cat "$ROOTDIR/statistics_config.json"
