#!/bin/dash
cd "$(dirname "$0")" || exit 1
_bashaspec_test_file="$(pwd)/$(basename "$0")"

test_test_fail() {
  out="$(./set-e-fail-test-xspec.sh)"
  [ $? -eq 1 ] || return 1
  expected="$(cat <<EOF
Running 3 tests
.x.
2 of 3 tests passed
1 failures:
  test_2 returned 1
    inside test_2
EOF
)"
  printf '%s' "$out" | tr -d '\n'; echo
  printf '%s' "$expected" | tr -d '\n'; echo
  [ "$out" = "$expected" ] || return 2
}

test_before_all_fail() {
  out="$(./set-e-fail-before-all-xspec.sh)"
  [ $? -eq 1 ] || return 1
  expected="$(cat <<EOF
Running 1 tests

0 of 0 tests passed
1 failures:
  Bail out! before_all returned 2
    inside before_all
EOF
)"
  printf '%s' "$out" | tr -d '\n'; echo
  printf '%s' "$expected" | tr -d '\n'; echo
  [ "$out" = "$expected" ] || return 2
}

test_after_all_fail() {
  out="$(./set-e-fail-after-all-xspec.sh)"
  [ $? -eq 1 ] || return 1
  expected="$(cat <<EOF
Running 1 tests
.
1 of 1 tests passed
1 failures:
  Bail out! after_all returned 2
    inside after_all
EOF
)"
  printf '%s' "$out" | tr -d '\n'; echo
  printf '%s' "$expected" | tr -d '\n'; echo
  [ "$out" = "$expected" ] || return 2
}

. ../bashaspec.sh
