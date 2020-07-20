#!/bin/bash

ROOTDIR=$1
REPODIR=$ROOTDIR/repositories

ls "$ROOTDIR"

while IFS= read -r line
do
  REPO_NAME=$(echo "$line" | cut -d ":" -f 1)

  cd "$REPODIR/$REPO_NAME"
  CONFIG_NAME=$(echo "$line" | cut -d ":" -f 2 | cut -d "." -f 1)

  DESCRIPTION_NAME=$(jq -r '.description_file' "$CONFIG_NAME.json")

  echo "$CONFIG_NAME:$DESCRIPTION_NAME" >> "$ROOTDIR/description-paths.txt"

done < "$ROOTDIR/tmp-register.txt"
