#!/bin/bash

# download a file from github
# this takes as input a json description of the file
# to support downloading from both a public repository aswell from a private repository
#
# arg1 = the description of the file
# arg2 = the target where the downloaded file has to be written
# arg3 = the PAT from a user having access to the repository

# The input json structure is of the form
# {
#   "organisation" : "",
#   "repository"   : "",
#   "filepath"     : "",
#   "branchtag"    : "",
#   "private"      : boolean
# }

FILEDESC=$1
TARGET=$2
TOKEN=$3

#-----------------------------------------------------------------------------#
# 
TMPDIR=/tmp

# clean
rm -f ${TMPDIR}/apifile.out
rm -f ${TMPDIR}/file.out

checkHTTPcode () {
        # HTTP code must be between 200 and 300, otherwise script fails
   if  [ "$1" -lt "200" ] ||  [ "$1" -ge "300" ]  ; then
	   echo "Download unsuccessful, possible new token should be inserted"
           exit 1
   fi
}

#-----------------------------------------------------------------------------#
#
# echo $FILEDESC | jq . 

ORG=`echo ${FILEDESC} | jq -r .organisation`
REPO=`echo ${FILEDESC} | jq -r .repository`
FILEPATH=`echo ${FILEDESC} | jq -r .filepath`
BRANCHTAG=`echo ${FILEDESC} | jq -r .branchtag`
PRIVATE=`echo ${FILEDESC} | jq -r .private`

if [ "${TOKEN}" != "" ] ; then
	echo "accessing private repository"
   STATUS=`curl -s -w "%{http_code}" -H "Authorization: token ${TOKEN}" -o ${TMPDIR}/apifile.out https://api.github.com/repos/${ORG}/${REPO}/contents/${FILEPATH}?ref=${BRANCHTAG}`
   checkHTTPcode ${STATUS}
   DOWNLOADURL=`jq -r .download_url ${TMPDIR}/apifile.out`
   STATUS=`curl -s -w "%{http_code}" -H "Authorization: token ${TOKEN}" -o ${TMPDIR}/file.out ${DOWNLOADURL}` 
   checkHTTPcode ${STATUS}
else
	echo "accessing pubic repository"
   STATUS=`curl -s -w "%{http_code}" -L -o ${TMPDIR}/file.out https://github.com/${ORG}/${REPO}/raw/${BRANCHTAG}/${FILEPATH}`
   checkHTTPcode ${STATUS}
fi

cp ${TMPDIR}/file.out ${TARGET}






