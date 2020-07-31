#!/bin/bash
cd "$(dirname "$0")" || exit 1
set -euo pipefail

test_test_fail() {
  out="$(./set-e-fail-test-xspec.sh)"$'\n'
  [[ $? -eq 1 ]] || return 1
  IFS= read -r -d '' expected <<EOF || true
Running 3 tests
.x.
2 of 3 tests passed
1 failures:
  test_2 returned 1
    inside test_2
EOF
  printf '%q\n' "$out"
  printf '%q\n' "$expected"
  [[ "$out" = "$expected" ]] || return 2
}

test_before_all_fail() {
  out="$(./set-e-fail-before-all-xspec.sh)"$'\n'
  [[ $? -eq 1 ]] || return 1
  IFS= read -r -d '' expected <<EOF || true
Running 1 tests

0 of 0 tests passed
1 failures:
  Bail out! before_all returned 2
    inside before_all
EOF
  printf '%q\n' "$out"
  printf '%q\n' "$expected"
  [[ "$out" = "$expected" ]] || return 2
}

test_after_all_fail() {
  out="$(./set-e-fail-after-all-xspec.sh)"$'\n'
  [[ $? -eq 1 ]] || return 1
  IFS= read -r -d '' expected <<EOF || true
Running 1 tests
.
1 of 1 tests passed
1 failures:
  Bail out! after_all returned 2
    inside after_all
EOF
  printf '%q\n' "$out"
  printf '%q\n' "$expected"
  [[ "$out" = "$expected" ]] || return 2
}

. ../bashaspec.sh
