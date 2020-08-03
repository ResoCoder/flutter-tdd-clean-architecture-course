#!/bin/sh

target='test_driver/app.dart'
features='test_driver/features'

files=$(find $features -maxdepth 3 -type f);
for file in $files
  do
  echo $file
  flutter drive --target=$target --driver=$file
done;