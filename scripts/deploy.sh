#!/bin/bash

#inspired from : https://github.com/unegma/bash-functions/blob/main/update.sh

VERSION=""

#get parameters
while getopts v: flag; do
  # shellcheck disable=SC2220
  case "${flag}" in v) VERSION=${OPTARG} ;;
  esac
done

#get highest tag number, and add 1.0.0 if doesn't exist
CURRENT_VERSION=$(git describe --abbrev=0 --tags 2>/dev/null)

if [[ $CURRENT_VERSION == '' ]]; then
  CURRENT_VERSION='release-1.0.0'
fi

CURRENT_VERSION=${CURRENT_VERSION:8}
echo "Current Version: release-$CURRENT_VERSION"

#replace . with space so can split into an array
# shellcheck disable=SC2206
CURRENT_VERSION_PARTS=(${CURRENT_VERSION//./ })

#get number parts
VNUM1=${CURRENT_VERSION_PARTS[0]}
VNUM2=${CURRENT_VERSION_PARTS[1]}
VNUM3=${CURRENT_VERSION_PARTS[2]}

if [[ $VERSION == 'major' ]]; then
  VNUM1=$((VNUM1 + 1))
  VNUM2=0
  VNUM3=0
elif [[ $VERSION == 'minor' ]]; then
  VNUM2=$((VNUM2 + 1))
  VNUM3=0
elif [[ $VERSION == 'patch' ]]; then
  VNUM3=$((VNUM3 + 1))
else
  echo "No version type (https://semver.org/) or incorrect type specified, try: -v [major, minor, patch]"
  exit 1
fi

#create new tag
NEW_TAG="release-$VNUM1.$VNUM2.$VNUM3"
echo "($VERSION) updating release-$CURRENT_VERSION to $NEW_TAG"

#get current hash and see if it already has a tag
GIT_COMMIT=$(git rev-parse HEAD)
NEEDS_TAG=$(git describe --contains $GIT_COMMIT 2>/dev/null)

#only tag if no tag already
#to publish, need to be logged in to npm, and with clean working directory: `npm login; git stash`
if [ -z "$NEEDS_TAG" ]; then
  npm version $VERSION
  echo "Tagged with $NEW_TAG"
  git push
  git push --tags
else
  echo "Already a tag on this commit"
fi

exit 0
