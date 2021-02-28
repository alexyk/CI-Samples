#!/bin/bash

set -e

echo
echo "Status"
echo '------'
echo
git status
echo
echo "Branches - Local"
echo '----------------'
echo
git branch -vv
echo
echo "Branches - Remote"
echo '-----------------'
echo
git branch -r | grep -v "/pr/"
echo
echo "Last 10 Commits"
echo '---------------'
echo
git log --oneline --decorate -10
echo
echo "Current Folder"
echo '--------------'
echo
pwd