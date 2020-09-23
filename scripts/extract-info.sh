#!/bin/bash

ROOTDIR=$1
REPODIR=$ROOTDIR/repositories
FILENAME="/root/project/standaardenregister.json"

ls "$ROOTDIR"

## Constructing file names for description
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

echo "Creating statistics configuration file"

## Constructing statistics configuration file
if cat "$FILENAME" | jq -e . >/dev/null 2>&1; then
  for row in $(jq -r '.[] | select(.repository)  | @base64 ' "$FILENAME"); do
    _jq() {
      echo "${row}" | base64 --decode | jq -r "${1}"
    }

    REPOSITORY=$(_jq '.repository')
    THEME_NAME=$(echo "$REPOSITORY" | cut -d '/' -f 5)
    CONFIG=$(_jq '.configuration')

    if [ ! -d "$REPODIR/$THEME_NAME" ]; then
      git clone "$REPOSITORY" "$REPODIR/$THEME_NAME"
    fi

    cd "$REPODIR/$THEME_NAME"
    git checkout standaardenregister
    NAME=$(cat "$CONFIG" | jq '.naam')
    REPORT_FILE=$(cat "$CONFIG" | jq '.rapport')

    echo "$NAME ---> $REPORT_FILE"

    if [ "$REPORT_FILE" == "" ]; then
      jq --arg NAAM "$SPEC_NAME" --arg REPORT "$REPORT_FILE" '. += [{"name": $NAAM, "report" : null}]' "$ROOTDIR/statistics_config.json" > "$ROOTDIR/statistics_config.json.tmp" && mv "$ROOTDIR/statistics_config.json.tmp" "$ROOTDIR/statistics_config.json"
    else
      jq --arg NAAM "$SPEC_NAME" --arg REPORT "$REPORT_FILE" '. += [{"name": $NAAM, "report" : $REPORT}]' "$ROOTDIR/statistics_config.json" > "$ROOTDIR/statistics_config.json.tmp" && mv "$ROOTDIR/statistics_config.json.tmp" "$ROOTDIR/statistics_config.json"
    fi
  done
fi

echo "Done creating statistics configuration file"
cat "$ROOTDIR/statistics_config.json"
