#!/bin/bash

set -e

echo
echo 'Get library'
echo '----------------------------------'
echo
yarn lib
echo
echo 'Install React Native dependencies'
echo '---------------------------------'
echo
yarn