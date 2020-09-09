#!/bin/bash

ROOTDIR=$1
REPODIR=$ROOTDIR/repositories

ls "$ROOTDIR"

while IFS= read -r line
do
  REPO_NAME=$(echo "$line" | cut -d ":" -f 1)
  SPEC_NAME=$(jq -r '.naam' "$CONFIG_NAME.json")

  cd "$REPODIR/$REPO_NAME"
  CONFIG_NAME=$(echo "$line" | cut -d ":" -f 2 | cut -d "." -f 1)

  ## Extract information about the statistics
  REPORT_FILE=$(jq -r '.report' "$CONFIG_NAME.json")

  if [ "$STATISTICS_FILE" == null ] || [ "$STATISTICS_FILE" == "" ]; then
     jq --arg NAAM "$STANDARD_NAME" --arg REPORT "$REPORT_FILE" '. += [{"naam": $NAAM, "report" : "$REPORT"}]' "$STATISTICS_CONFIG"
  fi

  ## Extract information about the files containing the description for the detail page
  DESCRIPTION_NAME=$(jq -r '.description_file' "$CONFIG_NAME.json")

  echo "$CONFIG_NAME:$DESCRIPTION_NAME" >> "$ROOTDIR/description-paths.txt"

  #### Constructing file name ####
  SPECIAL_CHARACTERS_REMOVED="${SPEC_NAME//[:&]/}"
  MULTI_SPACE_REMOVED="${SPECIAL_CHARACTERS_REMOVED//  /}"
  SPACE_REPLACED="${MULTI_SPACE_REMOVED// /-}"

  echo "$CONFIG_NAME:$SPACE_REPLACED" >> "$ROOTDIR/filenames.txt"

done < "$ROOTDIR/tmp-register.txt"

echo "$STATISTICS_CONFIG" > "$ROOTDIR/statistics_config.json"
echo "[extract-info.sh]: this is the output of the statistics_config.json file:"
echo "$ROOTDIR/statistics_config.json"
