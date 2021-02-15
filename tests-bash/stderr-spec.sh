#!/bin/bash
cd "$(dirname "$0")" || exit 1

test_dot_fail_after_all_shows_stderr() {
  out="$(./stderr-fail-after-all-xspec.sh)"$'\n'
  [[ $? -eq 1 ]] || return 1
  IFS= read -r -d '' expected <<EOF || true
Running 1 tests
.
1 of 1 tests passed
1 failures:
  Bail out! after_all returned 1
    inside after_all
EOF
  printf '%q\n' "$out"
  printf '%q\n' "$expected"
  [[ "$out" = "$expected" ]] || return 2
}

test_dot_fail_before_all_shows_stderr() {
  out="$(./stderr-fail-before-all-xspec.sh)"$'\n'
  [[ $? -eq 1 ]] || return 1
  IFS= read -r -d '' expected <<EOF || true
Running 1 tests

0 of 0 tests passed
1 failures:
  Bail out! before_all returned 1
    inside before_all
EOF
  printf '%q\n' "$out"
  printf '%q\n' "$expected"
  [[ "$out" = "$expected" ]] || return 2
}

test_dot_fail_before_and_after_each_shows_stderr() {
  out="$(./stderr-fail-before-and-after-each-xspec.sh)"$'\n'
  [[ $? -eq 1 ]] || return 1
  IFS= read -r -d '' expected <<EOF || true
Running 1 tests
x
0 of 1 tests passed
1 failures:
  test_pass_stderr after_each returned 1
    inside before_each
    inside after_each
EOF
  printf '%q\n' "$out"
  printf '%q\n' "$expected"
  [[ "$out" = "$expected" ]] || return 2
}

test_dot_fail_shows_stderr() {
  out="$(./stderr-fail-xspec.sh)"$'\n'
  [[ $? -eq 1 ]] || return 1
  IFS= read -r -d '' expected <<EOF || true
Running 1 tests
x
0 of 1 tests passed
1 failures:
  test_fail_stderr returned 1
    inside test_fail_stderr
EOF
  printf '%q\n' "$out"
  printf '%q\n' "$expected"
  [[ "$out" = "$expected" ]] || return 2
}

test_dot_pass_hides_stderr() {
  out="$(./stderr-pass-xspec.sh)"$'\n' || return 1
  IFS= read -r -d '' expected <<EOF || true
Running 1 tests
.
1 of 1 tests passed
EOF
  printf '%q\n' "$out"
  printf '%q\n' "$expected"
  [[ "$out" = "$expected" ]] || return 2
}

test_tap_fail_after_all_shows_stderr() {
  out="$(./stderr-fail-after-all-xspec.sh -v)"$'\n'
  [[ $? -eq 1 ]] || return 1
  IFS= read -r -d '' expected <<EOF || true
1..1
ok 1 test_pass_stderr
Bail out! after_all returned 1
# inside after_all
EOF
  printf '%q\n' "$out"
  printf '%q\n' "$expected"
  [[ "$out" = "$expected" ]] || return 2
}

test_tap_fail_before_all_shows_stderr() {
  out="$(./stderr-fail-before-all-xspec.sh -v)"$'\n'
  [[ $? -eq 1 ]] || return 1
  IFS= read -r -d '' expected <<EOF || true
1..1
Bail out! before_all returned 1
# inside before_all
EOF
  printf '%q\n' "$out"
  printf '%q\n' "$expected"
  [[ "$out" = "$expected" ]] || return 2
}

test_tap_fail_before_and_after_each_shows_stderr() {
  out="$(./stderr-fail-before-and-after-each-xspec.sh -v)"$'\n'
  [[ $? -eq 1 ]] || return 1
  IFS= read -r -d '' expected <<EOF || true
1..1
not ok 1 test_pass_stderr after_each
# test_pass_stderr after_each returned 1
# inside before_each
# inside after_each
EOF
  printf '%q\n' "$out"
  printf '%q\n' "$expected"
  [[ "$out" = "$expected" ]] || return 2
}

test_tap_fail_shows_stderr() {
  out="$(./stderr-fail-xspec.sh -v)"$'\n'
  [[ $? -eq 1 ]] || return 1
  IFS= read -r -d '' expected <<EOF || true
1..1
not ok 1 test_fail_stderr
# test_fail_stderr returned 1
# inside test_fail_stderr
EOF
  printf '%q\n' "$out"
  printf '%q\n' "$expected"
  [[ "$out" = "$expected" ]] || return 2
}

test_tap_pass_hides_stderr() {
  out="$(./stderr-pass-xspec.sh -v)"$'\n' || return 1
  IFS= read -r -d '' expected <<EOF || true
1..1
ok 1 test_pass_stderr
EOF
  printf '%q\n' "$out"
  printf '%q\n' "$expected"
  [[ "$out" = "$expected" ]] || return 2
}

. ../bashaspec.sh
