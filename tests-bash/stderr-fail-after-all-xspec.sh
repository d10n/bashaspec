#!/bin/bash
cd "$(dirname "$0")" || exit 1

after_all() {
  echo >&2 'inside after_all'
  return 1
}

test_pass_stderr() {
  echo >&2 'inside test_pass_stderr'
}

. ../bashaspec.sh
