#!/bin/bash
cd "$(dirname "$0")" || exit 1
. ../bashaspec.sh

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
  false
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
