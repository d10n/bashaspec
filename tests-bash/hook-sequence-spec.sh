#!/bin/bash
cd "$(dirname "$0")" || exit 1
_bashaspec_test_file="$(pwd)/$(basename "$0")"
. ../bashaspec.sh

test_before_all_fail_spec() {
  out="$(./before-all-fail-xspec.sh)"$'\n'
  [[ $? -eq 1 ]] || return 1
  IFS= read -r -d '' expected <<EOF || true
Running 3 tests

0 of 0 tests passed
1 failures:
  Bail out! before_all returned 1
    inside before_all
EOF
  printf '%q\n' "$out"
  printf '%q\n' "$expected"
  [[ "$out" = "$expected" ]] || return 2
}

test_before_all_pass_spec() {
  out="$(./before-all-pass-xspec.sh)"$'\n'
  [[ $? -eq 0 ]] || return 1
  IFS= read -r -d '' expected <<EOF || true
Running 3 tests
...
3 of 3 tests passed
EOF
  printf '%q\n' "$out"
  printf '%q\n' "$expected"
  [[ "$out" = "$expected" ]] || return 2
}

test_before_each_fail_spec() {
  out="$(./before-each-fail-xspec.sh)"$'\n'
  [[ $? -eq 1 ]] || return 1
  IFS= read -r -d '' expected <<EOF || true
Running 3 tests
xxx
0 of 3 tests passed
3 failures:
  test_1 before_each returned 1
    inside before_each
    inside after_each
  test_2 before_each returned 1
    inside before_each
    inside after_each
  test_3 before_each returned 1
    inside before_each
    inside after_each
EOF
  printf '%q\n' "$out"
  printf '%q\n' "$expected"
  [[ "$out" = "$expected" ]] || return 2
}

test_before_each_pass_spec() {
  out="$(./before-each-pass-xspec.sh)"$'\n'
  [[ $? -eq 0 ]] || return 1
  IFS= read -r -d '' expected <<EOF || true
Running 3 tests
...
3 of 3 tests passed
EOF
  printf '%q\n' "$out"
  printf '%q\n' "$expected"
  [[ "$out" = "$expected" ]] || return 2
}

test_after_each_pass_spec() {
  out="$(./after-each-pass-xspec.sh)"$'\n'
  [[ $? -eq 0 ]] || return 1
  IFS= read -r -d '' expected <<EOF || true
Running 3 tests
...
3 of 3 tests passed
EOF
  printf '%q\n' "$out"
  printf '%q\n' "$expected"
  [[ "$out" = "$expected" ]] || return 2
}

test_after_each_fail_spec() {
  out="$(./after-each-fail-xspec.sh)"$'\n'
  [[ $? -eq 1 ]] || return 1
  IFS= read -r -d '' expected <<EOF || true
Running 3 tests
xxx
0 of 3 tests passed
3 failures:
  test_1 after_each returned 1
    inside before_each
    inside test_1
    inside after_each
  test_2 after_each returned 1
    inside before_each
    inside test_2
    inside after_each
  test_3 after_each returned 1
    inside before_each
    inside test_3
    inside after_each
EOF
  printf '%q\n' "$out"
  printf '%q\n' "$expected"
  [[ "$out" = "$expected" ]] || return 2
}

test_before_and_after_each_fail_spec() {
  out="$(./before-and-after-each-fail-xspec.sh)"$'\n'
  [[ $? -eq 1 ]] || return 1
  IFS= read -r -d '' expected <<EOF || true
Running 3 tests
xxx
0 of 3 tests passed
3 failures:
  test_1 after_each returned 2
    inside before_each
    inside after_each
  test_2 after_each returned 2
    inside before_each
    inside after_each
  test_3 after_each returned 2
    inside before_each
    inside after_each
EOF
  printf '%q\n' "$out"
  printf '%q\n' "$expected"
  [[ "$out" = "$expected" ]] || return 2
}

test_after_all_pass_spec() {
  out="$(./after-all-pass-xspec.sh)"$'\n'
  [[ $? -eq 0 ]] || return 1
  IFS= read -r -d '' expected <<EOF || true
Running 3 tests
...
3 of 3 tests passed
EOF
  printf '%q\n' "$out"
  printf '%q\n' "$expected"
  [[ "$out" = "$expected" ]] || return 2
}

test_after_all_fail_spec() {
  out="$(./after-all-fail-xspec.sh)"$'\n'
  [[ $? -eq 1 ]] || return 1
  IFS= read -r -d '' expected <<EOF || true
Running 3 tests
...
3 of 3 tests passed
1 failures:
  Bail out! after_all returned 1
    inside after_all
EOF
  printf '%q\n' "$out"
  printf '%q\n' "$expected"
  [[ "$out" = "$expected" ]] || return 2
}

test_no_hooks_pass_spec() {
  out="$(./no-hooks-pass-xspec.sh)"$'\n'
  [[ $? -eq 0 ]] || return 1
  IFS= read -r -d '' expected <<EOF || true
Running 3 tests
...
3 of 3 tests passed
EOF
  printf '%q\n' "$out"
  printf '%q\n' "$expected"
  [[ "$out" = "$expected" ]] || return 2
}
