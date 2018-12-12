#!/bin/bash

# Pre-Requirements:
# - Install gitlab-cli: https://github.com/vishwanatharondekar/gitlab-cli
# TODO: pass multiple gems

usage() {
  echo 'Usage: ./update_gems.sh -a <assignee> -b <branch_name> -m <commit_message> -g <gem>'
}

echo_and_do() {
  echo "--- execute: $1"
  $1
}

APP_FOLDERS=(accounts bookmarks companies customer_report homepage landingpages lyc orders product_categories product_details product_review products serp user)
SYNC_DIR=$(cat ~/.wlwrc | grep WLW_SYNC_DIR | sed 's/WLW_SYNC_DIR=//g' | sed 's/\"//g')

# parse opts
while getopts a:m:b:g: option
do
case "${option}"
in
a) ASSIGNEE=${OPTARG};;
b) BRANCH_NAME=${OPTARG};;
g) GEM=${OPTARG};;
m) COMMIT_MSG=${OPTARG};;
*) echo "invalid Argument: ${OPTARG}"
esac
done

echo "0: $0, app_folders: $APP_FOLDERS, sync_dir: $SYNC_DIR, ASSIGNEE: $ASSIGNEE, BRANCH_NAME: $BRANCH_NAME, GEM: $GEM, COMMIT_MSG: $COMMIT_MSG"

if [[  $GEM && ${GEM-x} ]]
then
  for folder in "${APP_FOLDERS[@]}"
  do
    echo_and_do "cd $SYNC_DIR/$folder" || exit 42
    echo_and_do 'git reset --hard' || exit 42
    echo_and_do 'git clean -fd' || exit 42
    echo_and_do 'git co master' || exit 42
    echo_and_do "git push origin --delete $BRANCH_NAME"
    echo_and_do "git branch -D $BRANCH_NAME"
    echo_and_do 'git pull --rebase' || exit 42
    echo_and_do "git co -b $BRANCH_NAME" || exit 42
    echo_and_do "bundle update $GEM" || exit 42
    git commit -am "${COMMIT_MSG}" || exit 42
    echo_and_do "git push --set-upstream origin $BRANCH_NAME" || exit 42
    lab merge-request -a ASSIGNEE -b BRANCH_NAME -t master -r -s -m "${COMMIT_MSG}" || exit 42
  done
else
  echo "no Argument present"
  usage
fi
