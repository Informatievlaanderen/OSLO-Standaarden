ROOTDIR=$1
REPODIR=$ROOTDIR/repositories

mkdir -p "$ROOTDIR/descriptions"


while IFS= read -r line
do
  REPO_NAME=$(echo "$line" | cut -d ":" -f 1)
  #DESCRIPTION_NAME=$(echo "$line" | cut -d ":" -f 4)
  #DESCRIPTION_PATH="beschrijvingen/$DESCRIPTION_NAME"

  cd "$REPODIR/$REPO_NAME"

  CONFIG_NAME=$(echo "$line" | cut -d ":" -f 2 | cut -d "." -f 1)
  DESCRIPTION_NAME=$(jq -r '.description_file' "$CONFIG_NAME")
  DESCRIPTION_PATH="descriptions/$DESCRIPTION_NAME"

  if test -f "$DESCRIPTION_PATH" ; then
    node /app/index.js -f "$DESCRIPTION_PATH" -o "$ROOTDIR/descriptions/$DESCRIPTION_NAME-description.html"
  fi
done < "$ROOTDIR/tmp-register.txt"
