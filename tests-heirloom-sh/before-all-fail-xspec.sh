#!/usr/heirloom/bin/sh
cd "`dirname "$0"`" || exit 1
_bashaspec_test_file="`pwd`/`basename "$0"`"
. ../alternate-old-versions/bashaspec-ancient.sh
before_all() {
  echo 'inside before_all'
  false
}

after_all() {
  echo 'inside after_all'
  true
}

before_each() {
  echo 'inside before_each'
  true
}

after_each() {
  echo 'inside after_each'
  true
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
