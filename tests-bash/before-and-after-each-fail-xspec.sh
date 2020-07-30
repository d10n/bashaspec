#!/bin/bash
cd "$(dirname "$0")" || exit 1

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

. ../bashaspec.sh
