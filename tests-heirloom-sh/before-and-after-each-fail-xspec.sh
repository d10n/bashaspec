#!/usr/heirloom/bin/sh
cd "`dirname "$0"`" || exit 1
_bashaspec_test_file="`pwd`/`basename "$0"`"

before_all() {
  echo 'inside before_all'
  true
}

after_all() {
  echo 'inside after_all'
  true
}

before_each() {
  echo 'inside before_each'
  return 2
}

after_each() {
  echo 'inside after_each'
  return 3
}

test_1() {
  echo 'inside test_1'
  true
}

test_2() {
  echo 'inside test_2'
  true
}

test_3() {
  echo 'inside test_3'
  true
}

. ../alternate-old-versions/bashaspec-ancient.sh
