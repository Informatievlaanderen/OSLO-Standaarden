#!/bin/bash

ROOTDIR=$1
REPODIR=$ROOTDIR/repositories
DESCRIPTION_NAMES="$ROOTDIR/description-paths.txt"

mkdir -p "$ROOTDIR/descriptions"


while IFS= read -r line
do
  REPO_NAME=$(echo "$line" | cut -d ":" -f 1)
  #DESCRIPTION_NAME=$(echo "$line" | cut -d ":" -f 4)

  cd "$REPODIR/$REPO_NAME"

  CONFIG_NAME=$(echo "$line" | cut -d ":" -f 2 | cut -d "." -f 1)
  DESCRIPTION_NAME=$(grep "$CONFIG_NAME" "$DESCRIPTION_NAMES" | cut -d ":" -f 2)
  DESCRIPTION_NAME_NO_EXTENSION=$(echo "$DESCRIPTION_NAME" | cut -d "." -f 1)

  if test -f "$DESCRIPTION_PATH" ; then
    node /app/index.js -f "descriptions/$DESCRIPTION_NAME" -o "$ROOTDIR/descriptions/$DESCRIPTION_NAME_NO_EXTENSION-description.html"
  fi
done < "$ROOTDIR/tmp-register.txt"
