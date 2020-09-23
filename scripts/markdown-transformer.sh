#!/bin/bash

ROOTDIR=$1
REPODIR=$ROOTDIR/repositories
DESCRIPTION_NAMES="$ROOTDIR/description-paths.txt"

mkdir -p "$ROOTDIR/descriptions"


while IFS= read -r line
do
  REPO_NAME=$(echo "$line" | cut -d ":" -f 1)

  cd "$REPODIR/$REPO_NAME"

  CONFIG_NAME=$(echo "$line" | cut -d ":" -f 2 | cut -d "." -f 1)
  DESCRIPTION_NAME=$(grep "$CONFIG_NAME" "$DESCRIPTION_NAMES" | cut -d ":" -f 2)

  if [ -z "$DESCRIPTION_NAME" ]
  then
    echo "No description was provided for config file $CONFIG_NAME"
  else
    DESCRIPTION_NAME_NO_EXTENSION=$(echo "$DESCRIPTION_NAME" | cut -d "." -f 1)

    echo "Executing script for file $DESCRIPTION_NAME retrieved from config $CONFIG_NAME"

    # Execute the transform script
    node /app/index.js -f "descriptions/$DESCRIPTION_NAME" -o "$ROOTDIR/descriptions/$DESCRIPTION_NAME_NO_EXTENSION-description.html"
  fi


done < "$ROOTDIR/tmp-register.txt"

