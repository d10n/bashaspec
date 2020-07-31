#!/usr/heirloom/bin/sh
cd "`dirname "$0"`" || exit 1
_bashaspec_test_file="`pwd`/`basename "$0"`"
set -eu

test_1() {
  echo 'inside test_1'
  true
}

test_2() {
  echo 'inside test_2'
  # false # - does not work in heirloom bourne shell with set -e - must use return!
  return 1
}

test_3() {
  echo 'inside test_3'
  true
}

. ../alternate-old-versions/bashaspec-ancient.sh
