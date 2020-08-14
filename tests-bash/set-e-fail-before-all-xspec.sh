#!/usr/bin/env bash
cd "$(dirname "$0")" || exit 1
set -euo pipefail

before_all() {
  echo 'inside before_all'
  return 2
}

test_1() {
  echo 'inside test_1'
  true
}

. ../bashaspec.sh
