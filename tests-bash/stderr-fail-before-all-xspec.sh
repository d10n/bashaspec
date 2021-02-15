#!/bin/bash
cd "$(dirname "$0")" || exit 1

before_all() {
  echo >&2 'inside before_all'
  return 1
}

test_pass_stderr() {
  echo >&2 'inside test_pass_stderr'
}

. ../bashaspec.sh
