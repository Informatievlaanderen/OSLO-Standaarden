#!/bin/bash

## We always recreate the statistics file ##

FILENAME="/root/project/standaardenregister.json"
REPOSITORY_DIR="/tmp/workspace/repositories"
ROOTDIR=$1

## Creating statistics config file
touch "$ROOTDIR/statistics_config.json"
echo "[]" > "$ROOTDIR/statistics_config.json"

if cat "$FILENAME" | jq -e . >/dev/null 2>&1; then
  for row in $(jq -r '.[] | @base64 ' "$FILENAME"); do
    _jq() {
      echo "${row}" | base64 --decode | jq -r "${1}"
    }

    REPOSITORY=$(_jq '.repository')
    THEME_NAME=$(echo "$REPOSITORY" | cut -d '/' -f 5)
    CONFIG=$(_jq '.configuration')

    if [ ! -d "$REPOSITORY_DIR/$THEME_NAME" ]; then
      git clone "$REPOSITORY" "$REPOSITORY_DIR/$THEME_NAME"
    fi

    cd "$REPOSITORY_DIR/$THEME_NAME"
    NAME=$(cat "$CONFIG" | jq '.naam')
    REPORT_FILE=$(cat "$CONFIG" | jq '.rapport')

    if [ "$REPORT_FILE" == "" ]; then
      jq --arg NAAM "$SPEC_NAME" --arg REPORT "$REPORT_FILE" '. += [{"name": $NAAM, "report" : null}]' "$ROOTDIR/statistics_config.json" > "$ROOTDIR/statistics_config.json.tmp" && mv "$ROOTDIR/statistics_config.json.tmp" "$ROOTDIR/statistics_config.json"
    else
      jq --arg NAAM "$SPEC_NAME" --arg REPORT "$REPORT_FILE" '. += [{"name": $NAAM, "report" : $REPORT}]' "$ROOTDIR/statistics_config.json" > "$ROOTDIR/statistics_config.json.tmp" && mv "$ROOTDIR/statistics_config.json.tmp" "$ROOTDIR/statistics_config.json"
    fi
  done
fi

echo "Created statistics config file"
cat "$ROOTDIR/statistics_config.json"

node /app/bin/contributors.js -f "$ROOTDIR/statistics_config.json" -o "$ROOTDIR/statistics.json"

