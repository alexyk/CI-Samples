#!/bin/bash

case $1 in
  '--help' | '-help' | 'help' | '-h' | '?' | '/?' )
    cmd=`basename $0`
    echo '
      Usage:
        $cmd [environment]

      Examples:
        $cmd development
        $cmd production
        $cmd ui
        $cmd e2e
    '
    exit 1
    ;;
esac

ENV=$1
METRO_RUNNING=`lsof -i :8081 | grep -v CLOSED | wc -l | xargs`

set -e

if (($METRO_RUNNING > 1)); then
  echo
  echo 'Metro server is running already!'
  echo
  lsof -i :8081
  echo
  exit 1
fi

[ "$ENV" == "" ] && ENV='development'

FILE=".env.${ENV}"
[ -f $FILE ] && FILE_INFO="'$FILE'" \
             || FILE_INFO="n/a (file '$FILE' does not exist)"

echo
echo 'Start Metro Server'
echo '------------------'
echo "Environment: $FILE_INFO"
if [ $# -eq 0 ]; then
  # normal start when no arguments
  npx react-native start
else
  # start with resetting cache when arguments
  APP_ENV=$ENV npx react-native start --reset-cache
fi
