#!/bin/bash

# Prepare test environment
echo
echo 'Prepare Test Environment'
echo '------------------------'
echo
mv -v __test-env__/mocks ../__mocks__
mv -v __test-env__/* ../
mv -v __test-env__/.eslint* ../
cd ..

# install
echo
echo 'Install Test Environment Dependencies'
echo '-------------------------------------'
echo
yarn