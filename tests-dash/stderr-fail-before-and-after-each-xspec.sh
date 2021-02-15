#!/bin/dash
cd "$(dirname "$0")" || exit 1
_bashaspec_test_file="$(pwd)/$(basename "$0")"

before_each() {
  echo >&2 'inside before_each'
  return 1
}

after_each() {
  echo >&2 'inside after_each'
  return 1
}

test_pass_stderr() {
  echo >&2 'inside test_pass_stderr'
}

. ../bashaspec.sh
