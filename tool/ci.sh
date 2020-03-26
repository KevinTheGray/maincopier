#!/bin/bash

set -e

cd $1
package=${PWD##*/}

if grep -q 'sdk: flutter' "./pubspec.yaml"; then
    flutter packages get
    flutter format --set-exit-if-changed lib test
    flutter analyze lib test
    flutter test --no-pub
elif grep -q 'angular:' "./pubspec.yaml"; then
    pub get
    dartfmt --dry-run --set-exit-if-changed .
    dartanalyzer --fatal-infos --fatal-warnings . || EXIT_CODE=$?
    pub run build_runner test --fail-on-severe
else
    pub get
    dartfmt --dry-run --set-exit-if-changed .
    dartanalyzer --fatal-infos --fatal-warnings . || EXIT_CODE=$?
    pub run test
fi

cd -