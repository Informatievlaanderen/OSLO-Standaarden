#!/bin/bash

ROOTDIR=$1
REPODIR=$ROOTDIR/repositories
DESCRIPTION_PATHS="$ROOTDIR/description-paths.txt"

mkdir -p "$ROOTDIR/descriptions"


while IFS= read -r line
do
  REPO_NAME=$(echo "$line" | cut -d ":" -f 1)
  #DESCRIPTION_NAME=$(echo "$line" | cut -d ":" -f 4)

  cd "$REPODIR/$REPO_NAME"

  CONFIG_NAME=$(echo "$line" | cut -d ":" -f 2 | cut -d "." -f 1)
  DESCRIPTION_PATH=$(grep "$CONFIG_NAME" $DESCRIPTION_PATHS | cut -d ":" -f 2)

echo $DESCRIPTION_PATH
  #if test -f "$DESCRIPTION_PATH" ; then
  #  node /app/index.js -f "$DESCRIPTION_PATH" -o "$ROOTDIR/descriptions/$DESCRIPTION_NAME_NO_EXTENSION-description.html"
  #fi
done < "$ROOTDIR/tmp-register.txt"
