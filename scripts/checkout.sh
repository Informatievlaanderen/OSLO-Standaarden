#!/bin/bash

PUBCONFIG=$2
ROOTDIR=$1

# Determine the last changed files
mkdir -p "$ROOTDIR"
curl -o "$ROOTDIR/commit.json" https://raw.githubusercontent.com/Informatievlaanderen/OSLO-StandaardenregisterGenerated/master/commit.json
sleep 5s
jq . "$ROOTDIR/commit.json"
if [ $? -eq 0 ]; then
  PREV_COMMIT=$(jq -r .commit "$ROOTDIR/commit.json")
  changedFiles=$(git diff --name-only "$PREV_COMMIT")
  if [ "$changedFiles" == "standaardenregister.json" ]
  then
    echo "One or more standards seem to be modified"
    echo "These standards were modified:"
    git show "$PREV_COMMIT:standaardenregister.json" > previous_version
    jq -s '.[0] - .[1]' standaardenregister.json previous_version
    jq -s '.[0] - .[1]' standaardenregister.json previous_version > "$ROOTDIR/changedstandards.json"
    cat "$ROOTDIR/changedstandards.json"
  else
    echo "One or more files were changed, possibly a script, so a full rebuild is necessary"
    cp "${PUBCONFIG}" "$ROOTDIR/changedstandards.json"
  fi

else
  # No previous commit
  # Doing full rebuild of all standards
  echo "No previous commit was made."
  echo "Processing all standards in standaardenregister.json"
  cp "$PUBCONFIG" "$ROOTDIR/changedstandards.json"
fi

#Process all standards that have been changed or were added
echo "Start processing the standards"
if cat "$ROOTDIR/changedstandards.json" | jq -e . >/dev/null 2>&1; then
  # Only iterate over those that have a repository
  for row in $(jq -r '.[] | select(.repository)  | @base64 ' "$ROOTDIR/changedstandards.json"); do
    _jq() {
      echo "${row}" | base64 --decode | jq -r "${1}"
    }

    # Get name of repository to create a directory with the same name
    REPOSITORY=$(_jq '.repository')
    STATUS=$(_jq '.status')
    CONFIG=$(_jq '.configuration')
    CONFIG_NAME=$(echo "$CONFIG" | cut -d "." -f 1)

    THEME_NAME=$(echo "$REPOSITORY" | cut -d '/' -f 5)

    mkdir -p "$ROOTDIR/repositories/$THEME_NAME"

    ### We convert the standards register from JSON to a simple text file
    echo 'Writing data to the temp file: tmp-register.txt'
    echo "$THEME_NAME:$CONFIG:$STATUS" >> "$ROOTDIR/tmp-register.txt"

    ### Cloning repository and checking out branch standaardenregister
    git clone "$REPOSITORY" "$ROOTDIR/repositories/$THEME_NAME"
    cd "$ROOTDIR/repositories/$THEME_NAME"
    git checkout standaardenregister

    # We extend the the configuration file for a specific file in a theme with the baseURL
    BASE_URL="https://github.com/Informatievlaanderen/$THEME_NAME/raw/standaardenregister"
    jq --arg BASE_URL "$BASE_URL" '. |= . + {"baseURL" : $BASE_URL}' "$CONFIG" > "$CONFIG-extended.json"

    echo "Done processing"

  done
else
  echo "Problem processing following file: $ROOTDIR/changedstandards.json"
fi
