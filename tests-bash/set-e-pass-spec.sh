#!/usr/bin/env bash
cd "$(dirname "$0")" || exit 1
set -euo pipefail

test_1() {
  echo 'inside test_1'
  true
}

test_2() {
  echo 'inside test_2'
  true
}

test_3() {
  echo 'inside test_3'
  true
}

. ../bashaspec.sh
