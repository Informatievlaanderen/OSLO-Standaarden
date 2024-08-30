#!/bin/bash

set -x

# checkout a full repository from GitHub
# this takes as input a json description of the file
# to support cloning a public repository aswell a private repository
#
# arg1 = the description of the file
# arg2 = the target where the downloaded file has to be written
# arg3 = the PAT from a user having access to the repository
#    
# for more information on PAT (Personal Access Token) see 
# https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/managing-your-personal-access-tokens

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

rm -rf ${TARGET} 
mkdir -p ${TARGET}


checkHTTPcode () {
        # HTTP code must be between 200 and 300, otherwise script fails
   if  [ "$1" -lt "200" ] ||  [ "$1" -ge "300" ]  ; then
	   echo "Access unsuccessful, possible new token should be inserted"
           exit 1
   fi
}

checkHTTPcodeContinue () {
        # HTTP code must be between 200 and 300, otherwise script fails
   if  [ "$1" -lt "200" ] ||  [ "$1" -ge "300" ]  ; then
	   echo "Access unsuccessful, possible new token should be inserted"
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
	echo "cloning private repository"
   STATUS=`curl -s -w "%{http_code}" -H "Authorization: token ${TOKEN}" -o ${TMPDIR}/apifile.out https://api.github.com/repos/${ORG}/${REPO}`
   checkHTTPcode ${STATUS}
   CLONEURL=`jq -r .ssh_url ${TMPDIR}/apifile.out`
   git clone ${CLONEURL} ${TARGET}
else
	echo "cloning public repository"
   if [ "${PRIVATE}" == "true" ] & [ "${TOKEN}" == "" ] ; then
	echo "WARNING: trying to clone a private repo without token"
        STATUS=`curl -s -w "%{http_code}" -o ${TMPDIR}/apifile.out https://api.github.com/repos/${ORG}/${REPO}`
        checkHTTPcodeContinue ${STATUS}
	echo "WARNING: try clone a private repo using ssh"
        CLONEURL="git@github.com:${ORG}/${REPO}.git"
        git clone ${CLONEURL} ${TARGET}
   else 
      STATUS=`curl -s -w "%{http_code}" -o ${TMPDIR}/apifile.out https://api.github.com/repos/${ORG}/${REPO}`
      checkHTTPcode ${STATUS}
      CLONEURL=`jq -r .ssh_url ${TMPDIR}/apifile.out`
      git clone ${CLONEURL} ${TARGET}
   fi
fi







