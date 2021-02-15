#!/bin/dash
cd "$(dirname "$0")" || exit 1
_bashaspec_test_file="$(pwd)/$(basename "$0")"

test_fail_stderr() {
  echo >&2 'inside test_fail_stderr'
  return 1
}

. ../bashaspec.sh
