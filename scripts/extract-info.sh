#!/bin/bash

ROOTDIR=$1
REPODIR=$ROOTDIR/repositories

ls "$ROOTDIR"

## Creating statistics config file
touch "$ROOTDIR/statistics_config.json"
echo "[]" > "$ROOTDIR/statistics_config.json"

while IFS= read -r line
do
  REPO_NAME=$(echo "$line" | cut -d ":" -f 1)

  cd "$REPODIR/$REPO_NAME"
  CONFIG_NAME=$(echo "$line" | cut -d ":" -f 2 | cut -d "." -f 1)
  SPEC_NAME=$(jq -r '.naam' "$CONFIG_NAME.json")

  ## Extract information about the statistics
  REPORT_FILE=$(jq -r '.rapport' "$CONFIG_NAME.json")

  if [ "$REPORT_FILE" == "" ]; then
     jq --arg NAAM "$SPEC_NAME" --arg REPORT "$REPORT_FILE" '. += [{"name": $NAAM, "report" : null}]' "$ROOTDIR/statistics_config.json" > "$ROOTDIR/statistics_config.json.tmp" && mv "$ROOTDIR/statistics_config.json.tmp" "$ROOTDIR/statistics_config.json"
  else
    jq --arg NAAM "$SPEC_NAME" --arg REPORT "$REPORT_FILE" '. += [{"name": $NAAM, "report" : $REPORT}]' "$ROOTDIR/statistics_config.json" > "$ROOTDIR/statistics_config.json.tmp" && mv "$ROOTDIR/statistics_config.json.tmp" "$ROOTDIR/statistics_config.json"
  fi

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
