#!/bin/bash

ROOTDIR=/tmp/workspace
RESULTDIR=/tmp/workspace/html_pages
REPODIR=/tmp/workspace/repositories
DESCRIPTION_NAMES="$ROOTDIR/description-paths.txt"
FILENAMES="$ROOTDIR/filenames.txt"

mkdir -p "$RESULTDIR/erkende-standaard"
mkdir -p "$RESULTDIR/standaard-in-ontwikkeling"
mkdir -p "$RESULTDIR/kandidaat-standaard"
mkdir -p "$RESULTDIR/zonder-status"

mkdir -p "$RESULTDIR"

while IFS= read -r line
do
  REPO_NAME=$(echo "$line" | cut -d ":" -f 1)
  CONFIG=$(echo "$line" | cut -d ":" -f 2)
  CONFIG_NAME=$(echo "$CONFIG" | cut -d "." -f 1)
  DESCRIPTION_NAME=$(grep -w ^"$CONFIG_NAME" "$DESCRIPTION_NAMES" | cut -d ":" -f 2)
  DESCRIPTION_NAME_NO_EXTENSION=$(echo "$DESCRIPTION_NAME" | cut -d "." -f 1)
  DESCRIPTION="$ROOTDIR/descriptions/$DESCRIPTION_NAME_NO_EXTENSION-description.html"
  STATUS=$(echo "$line" | cut -d ":" -f 3)

  FILENAME=$(cat "$FILENAMES" | grep  -w ^"$CONFIG_NAME" | cut -d ":" -f 2)

  FULL_REPO_PATH="$REPODIR/$REPO_NAME"

  ## Go to HTML-page-generator
  cd /app
  if test -f "$DESCRIPTION" ; then
    echo "A description was provided for repository: $REPO_NAME"
    node html_page_generator.js -f "$FULL_REPO_PATH/$CONFIG-extended.json" -o "$RESULTDIR/$STATUS/${FILENAME,,}.html" -t "$DESCRIPTION"
  else
    echo "No description was provided for repository: $REPO_NAME"
    node html_page_generator.js -f "$FULL_REPO_PATH/$CONFIG-extended.json" -o "$RESULTDIR/$STATUS/${FILENAME,,}.html"
  fi

done < "$ROOTDIR/tmp-register.txt"
