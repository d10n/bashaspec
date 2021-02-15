#!/bin/bash
cd "$(dirname "$0")" || exit 1

test_fail_stderr() {
  echo >&2 'inside test_fail_stderr'
  return 1
}

. ../bashaspec.sh
