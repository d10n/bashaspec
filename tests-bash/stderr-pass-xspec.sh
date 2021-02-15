#!/bin/bash
cd "$(dirname "$0")" || exit 1

before_all() {
  echo >&2 'inside before_all'
}

after_all() {
  echo >&2 'inside after_all'
}

before_each() {
  echo >&2 'inside before_each'
}

after_each() {
  echo >&2 'inside after_each'
}

test_pass_stderr() {
  echo >&2 'inside test_pass_stderr'
}

. ../bashaspec.sh
