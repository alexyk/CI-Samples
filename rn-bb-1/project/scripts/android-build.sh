#!/bin/bash

set -e

cd android
if [ "$1" == 'release' ]; then
  echo
  echo 'Building Android RELEASE'
  echo '-------------------------'
  echo
  ./gradlew app:assembleRelease
else
  echo
  echo 'Building Android DEBUG'
  echo '----------------------'
  echo
  ./gradlew app:assembleDebug
fi
