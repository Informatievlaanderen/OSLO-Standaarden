#!/bin/bash

PUBCONFIG=$2
ROOTDIR=$1

# Determine the last changed files
mkdir -p "$ROOTDIR"
if false; then
  # Previous commit was made
  # TODO: Implement the logic to determine the changed files rather than a full rebuild of the standards
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
    echo "$THEME_NAME:$CONFIG:$STATUS" >>"$ROOTDIR/tmp-register.txt"

    ### Cloning repository and checking out branch standaardenregister
    git clone "$REPOSITORY" "$ROOTDIR/repositories/$THEME_NAME"
    cd "$ROOTDIR/repositories/$THEME_NAME"
    git checkout standaardenregister

    echo "Done processing"

  done
else
  echo "Problem processing following file: $ROOTDIR/changedstandards.json"
fi
