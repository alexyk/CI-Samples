#!/bin/bash

VERBOSE=0
DEPENDENCIES=0
SKIP_BUILD=1
IOS_ONLY=1
RELEASE=0
TEST_MODE=ui
EXTRA_PARAM=
# EXTRA_PARAM="--loglevel trace"
METRO_RUNNING=`lsof -i :8081 | grep -v CLOSED | wc -l | xargs`
ENV='ui'

set -e


while [ $# -gt 0 ]; do
  case $1 in
    '--e2e' | 'e2e' ) TEST_MODE='e2e'; ENV='e2e' ;;
    '--verbose' | 'verbose' | '-v' ) VERBOSE=1 ;;
    '--yarn' | 'yarn' | '--deps' | 'deps' | '--dependencies' | 'dependencies' ) DEPENDENCIES=1 ;;
    '--build' | 'build' ) SKIP_BUILD=0 ;;
    '--full' | 'full' ) IOS_ONLY=0; SKIP_BUILD=0; DEPENDENCIES=1 ;;
    '--both' | 'both' ) IOS_ONLY=0 ;;
    '--release' | 'release' ) RELEASE=1 ;;
    '--ui' | 'ui' | \
    '--ios' | 'ios' ) # defaults - nothing to do
      ;;
    '--help' | '-help' | 'help' | '-h' | '?' | '/?' )
      cmd=`basename $0`
      echo '
        Usage:
          $cmd [environment] [options...]

        Default mode without parameters is to:
          1. Setup dependencies with yarn and run `pod install` in ios folder
          2. Start metro server
          3. Build for iOS Debug
          4. Run UI tests on iOS Simulator (aka integration/functional)
          5. Build for Android Debug
          6. Run ui tests on Android Emulator

Environments:
  Any .env.<environment-file> can be used.
  If not setting `DETOX_TEST_MODE` inside your .env file - `ui` testing mode will be used.
  If adding option `e2e` - `e2e` testing mode will be used.
  Look at `.env.template` for possible options.

Options:
  e2e               sets testing mode to `e2e` (default is `ui`)
  verbose           sets verbose mode
  yarn, deps        enables getting library, dependencies with yarn and pod install (default these are off)
  build             enables building the app (default is off)
  both              build both iOS and Android (default is iOS only)
  full              all tasks - install dependencies, build and test both iOS & Android
                    (same as `both`, `full-cycle` and `build` options together)
  release           build for release

  --help, -help, help, -h, ?, /?          this help message

  Any option not in the list is interpreted as an Environment.
      '
      exit 1
      ;;
    *)
      ENV="$1"
      ;;
  esac
  shift
done

FILE=".env.${ENV}"
[ -f $FILE ] && source $FILE
[ -f $FILE ] && FILE_INFO="'$FILE'" \
             || FILE_INFO="n/a (file '$FILE' does not exist)"

((DETOX_VERBOSE)) && VERBOSE=1
((DETOX_BUILD_IOS_ONLY)) && IOS_ONLY=1
((DETOX_SKIP_BUILD)) && ( SKIP_BUILD=1 )
((DETOX_TEST_MODE)) && TEST_MODE=$DETOX_TEST_MODE
((DETOX_SKIP_DEPENDENCIES)) && DEPENDENCIES=0

if ((RELEASE)); then
  e2e_suffix='-release'
  build_cfg_a='release'
  build_cfg_i='Release'
else
  e2e_suffix=''
  build_cfg_a=''
  build_cfg_i='Debug'
fi


# =========================  START  ==============================

echo
echo '======================================================='
echo "          TEST MODE: '$TEST_MODE'"
echo "          File: $FILE_INFO"
echo '-------------------------------------------------------'
echo -n '       Install Dependencies: '
((DEPENDENCIES)) && echo 'yes' || echo 'no'
echo -n '                      Build: '
((IOS_ONLY)) \
  && (((SKIP_BUILDING)) && echo 'no' || echo 'iOS only') \
  || (((SKIP_BUILDING)) && echo 'no' || echo 'both Android & iOS')
echo -n '                Start Metro: '
((METRO_RUNNING > 1)) && echo 'already running' || echo 'yes'
echo '======================================================='

if ((DEPENDENCIES)); then
  echo
  echo 'Get Library'
  echo '-----------'
  echo
  yarn lib

  echo
  echo 'Install RN Dependencies'
  echo '-----------------------'
  echo
  yarn

  echo
  echo 'Install Pods'
  echo '------------'
  echo
  cd ios
  pod install
  cd ..
fi

if ((METRO_RUNNING <= 1)); then
  echo
  echo 'Start Metro Server'
  echo '------------------'
  echo "Environment: '.env.${ENV}'"
  APP_ENV=$TEST_MODE npx react-native start --reset-cache&
  echo
  sleep 1
fi

if ((SKIP_BUILD == 0)); then
  echo
  echo 'Build for iOS'
  echo '-------------'
  echo
  ((VERBOSE)) \
    && yarn ios-verbose --configuration $build_cfg_i \
    || yarn ios --configuration $build_cfg_i
fi

echo
echo 'Setup Detox'
echo '-----------'
echo "Test Mode: $TEST_MODE"
cp -v e2e/detox.config-"$TEST_MODE".js detox.config.js
echo

echo
echo 'Test in iOS Simulator'
echo '---------------------'
echo
((VERBOSE)) \
  && detox test $EXTRA_PARAM --configuration ios"$e2e_suffix" -l trace\
  || detox test $EXTRA_PARAM --configuration ios"$e2e_suffix"

((IOS_ONLY)) && exit 0


echo
echo 'Build for Android'
echo '-----------------'
echo
((VERBOSE)) \
  && yarn android-verbose --variant=$build_cfg_a \
  || yarn android --variant=$build_cfg_a

echo
echo 'Test in Android Emulator'
echo '------------------------'
echo
((VERBOSE)) \
  && detox test $EXTRA_PARAM --configuration android"$e2e_suffix" -l trace\
  || detox test $EXTRA_PARAM --configuration android"$e2e_suffix"