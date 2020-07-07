PAGES=/tmp/workspace/html_pages
GENERATED=/tmp/OSLO-StandaardenregisterGenerated/public



## A theme moves from candidate-standard to standard

if [ -d "$PAGES/erkende-standaard" ]
then
  if [ ! "$(ls $PAGES/erkende-standaard)" ]
  then
    echo "Directory $PAGES/erkende-standaard is empty"
  else
    for file in $(ls "$PAGES/erkende-standaard")
    do
      echo "Processing following file in erkende-standaard: $file"
      if test -f $GENERATED/kandidaat-standaard/$file
      then
        echo "      File exists in kandidaat-standaard, so delete it"
        rm $GENERATED/kandidaat-standaard/$file
      fi
    done
  fi
fi

## A theme moves from standard in development to candidate-standard or from standard to candidate-standard

if [ -d "$PAGES/kandidaat-standaard" ]
then
  if [ ! "$(ls $PAGES/kandidaat-standaard)" ]
  then
    echo "Directory $PAGES/kandidaat-standaard is empty"
  else
    for file in $(ls "$PAGES/kandidaat-standaard")
    do
      echo "Processing following file in kandidaat-standaard: $file"
      if test -f $GENERATED/standaard-in-ontwikkeling/$file
      then
        echo "   File exists in standaard-in-ontwikkeling, so delete it"
        rm $GENERATED/standaard-in-ontwikkeling/$file
      fi

      if test -f $GENERATED/erkende-standaard/$file
      then
        echo "    File exists in erkende-standaard, so delete it"
        rm $GENERATED/erkende-standaard/$file
      fi
    done
  fi
fi

## A theme moves from candidate-standard to standard in development

if [ -d "$PAGES/standaard-in-ontwikkeling" ]
then
  if [ ! "$(ls $PAGES/standaard-in-ontwikkeling)" ]
  then
    echo "Directory $PAGES/standaard-in-ontwikkeling is empty"
  else
    for file in $(ls "$PAGES/standaard-in-ontwikkeling")
    do
      echo "Processing following file in standaard-in-ontwikkeling: $file"
      if test -f $GENERATED/kandidaat-standaard/$file
      then
        echo "    File exists in kandidaat-standaard, so delete it"
        rm $GENERATED/kandidaat-standaard/$file
      fi
      if test -f $GENERATED/erkende-standaard/$file
      then
        echo "    File exists in erkende-standaard, so delete it"
        rm $GENERATED/erkende-standaard/$file
      fi
    done
  fi
fi
