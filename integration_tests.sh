#!/bin/sh

## script to trigger integration tests for each test file
target='test_driver/app.dart'
features='test_driver/features'

files=$(find $features -maxdepth 3 -type f);
for file in $files
  do
  echo $file

  # --no-build is to speed up the tests.
  # TODO: specify devices
  flutter drive --no-build --target=$target --driver=$file
done;