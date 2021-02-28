#!/bin/bash

set -e

echo
echo "Mobile App Status"
echo '-----------------'
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
echo "Last 5 Commits"
echo '--------------'
echo
git log --oneline --decorate -5
