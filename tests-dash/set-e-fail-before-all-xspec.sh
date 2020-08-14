#!/usr/bin/env dash
cd "$(dirname "$0")" || exit 1
_bashaspec_test_file="$(pwd)/$(basename "$0")"
set -eu

before_all() {
  echo 'inside before_all'
  return 2
}
test_1() {
  echo 'inside test_1'
  true
}

. ../bashaspec.sh
