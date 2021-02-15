#!/bin/dash
cd "$(dirname "$0")" || exit 1
_bashaspec_test_file="$(pwd)/$(basename "$0")"

before_all() {
  echo >&2 'inside before_all'
  return 1
}

test_pass_stderr() {
  echo >&2 'inside test_pass_stderr'
}

. ../bashaspec.sh
