#!/bin/bash
cd "$(dirname "$0")" || exit 1
_bashaspec_test_file="$(pwd)/$(basename "$0")"
. ../bashaspec.sh
test_concat() {
  a='1'
  b='2'
  echo 'concatenating...'
  c="$a$b"
  [[ "$c" = "12" ]] || return 1
  [[ "$c" != "ab" ]] || return 2
  [[ "$c" -ne 3 ]] || return 3
}
test_add() {
  a='1'
  b='2'
  echo 'adding...'
  c=$(( a+b ))
  [[ "$c" -eq 3 ]] || return 1
  [[ "$c" != "12" ]] || return 2
  [[ "$c" != "ab" ]] || return 2
}
test_an_error() {
  echo 'returning nonzero is an error'
  echo 'using return codes can identify the failing assertion'
  [[ 'a' = 'a' ]] || return 1
  [[ 'a' = 'b' ]] || return 2 # causes return 2!
  [[ 'a' = 'c' ]] && return 3
}
test_a_success() {
  now="$(date +%s)"
  future=$((now+1))
  (( now < future )) || return 1
}
