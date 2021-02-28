#!/bin/bash

# Used for moving back files to `__test-env__` when developing

mv yarn.lock build/__test-env__
mv *.t* build/__test-env__
mv *.j* build/__test-env__
mv .eslint* build/__test-env__
mv __mocks__ build/__test-env__/mocks
