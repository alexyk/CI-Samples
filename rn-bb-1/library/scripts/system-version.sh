#!/bin/bash

set -e

npm version
yarn versions
npx react-native info

echo "----- Disk Space  -----"
df -h