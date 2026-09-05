#!/bin/bash


PWD=$(pwd)
#. ${PWD}/.myconfig.sh
space=rocker
repo=verse
tag=4.4.1

if [[ "$1" == "-h" ]]
then
cat << EOF
$0 (tag)

will start interactive environment for tag (TAG)
EOF
exit 0
fi

if [[ ! -z "$1" ]]
then
  tag=${1}
fi

echo "Using tag = $tag"

case $USER in
  codespace)
  WORKSPACE=/workspaces
  ;;
  *)
  WORKSPACE=$PWD
  ;;
esac
  
# pull the docker if necessary
# set -ev

# tag_present=$(docker images | grep $space/$repo | awk ' { print $2 } ' | grep $tag)

# if [[ -z "$tag_present" ]]
# then
#   echo "Pulling $space/$repo:$tag"
#   docker pull $space/$repo:$tag
# else  
#   echo "Found $space/$repo:$tag"
# fi

[[ -d "$PWD/.cache" ]] || mkdir "$PWD/.cache"
if [[ -d "$PWD/.cache" ]] 
then 
  export DOCKEREXTRA="$DOCKEREXTRA -v $PWD/.cache:/home/rstudio/.cache"
fi
source $(pwd)/.Renviron
if [[ ! -z $QUALTRICS_API_KEY ]]; then export DOCKEREXTRA="$DOCKEREXTRA -e QUALTRICS_API_KEY=$QUALTRICS_API_KEY" ; fi
if [[ ! -z $QUALTRICS_BASE_URL ]]; then export DOCKEREXTRA="$DOCKEREXTRA -e QUALTRICS_BASE_URL=$QUALTRICS_BASE_URL" ; fi
# Do this for the Dataverse variables
if [[ ! -z $DATAVERSE_TOKEN ]]; then export DOCKEREXTRA="$DOCKEREXTRA -e DATAVERSE_TOKEN=$DATAVERSE_TOKEN" ; fi
if [[ ! -z $DATAVERSE_SERVER ]]; then export DOCKEREXTRA="$DOCKEREXTRA -e DATAVERSE_SERVER=$DATAVERSE_SERVER" ; fi
if [[ ! -z $DATAVERSE_DATASET_DOI ]]; then export DOCKEREXTRA="$DOCKEREXTRA -e DATAVERSE_DATASET_DOI=$DATAVERSE_DATASET_DOI" ; fi
# same for GITHUB_REPOSITORY
if [[ ! -z $GITHUB_REPOSITORY ]]; then export DOCKEREXTRA="$DOCKEREXTRA -e GITHUB_REPOSITORY=$GITHUB_REPOSITORY" ; fi


docker run $DOCKEREXTRA -e DISABLE_AUTH=true -v "$WORKSPACE":/home/rstudio/project -w /home/rstudio/project --rm -p 8787:8787 $space/$repo:$tag
