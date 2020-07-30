#!/bin/dash
cd "$(dirname "$0")" || exit 1
_bashaspec_test_file="$(pwd)/$(basename "$0")"

test_return_no_code_specified() {
  out="$(./test-return-xspec.sh)"
  [ $? -eq 1 ] || return 1
  expected="$(cat <<EOF
Running 1 tests
x
0 of 1 tests passed
1 failures:
  test_return_no_code_specified returned 3
EOF
)"
  printf '%s' "$out" | tr -d '\n'; echo
  printf '%s' "$expected" | tr -d '\n'; echo
  [ "$out" = "$expected" ] || return 2
}

. ../bashaspec.sh
