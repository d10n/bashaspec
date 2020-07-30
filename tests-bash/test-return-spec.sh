#!/bin/bash
cd "$(dirname "$0")" || exit 1

test_return_no_code_specified() {
  out="$(./test-return-xspec.sh)"$'\n'
  [[ $? -eq 1 ]] || return 1
  IFS= read -r -d '' expected <<EOF || true
Running 1 tests
x
0 of 1 tests passed
1 failures:
  test_return_no_code_specified returned 3
EOF
  printf '%q\n' "$out"
  printf '%q\n' "$expected"
  [[ "$out" = "$expected" ]] || return 2
}

. ../bashaspec.sh
