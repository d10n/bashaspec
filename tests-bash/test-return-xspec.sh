#!/usr/bin/env bash
cd "$(dirname "$0")" || exit 1

test_return_no_code_specified() {
  (exit 3) || return
  return 2
}

. ../bashaspec.sh
