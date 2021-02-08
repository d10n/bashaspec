#!/bin/bash
cd "$(dirname "$0")" || exit 1
test_concat() {
  a='1'
  b='2'
  echo 'concatenating...'
  c="$a$b"
  [[ "$c" = "12" ]] || return
}
test_add() {
  a='1'
  b='2'
  echo 'adding...'
  c=$(( a + b ))
  [[ "$c" -eq 3 ]] || return
}
test_an_error() {
  echo 'returning nonzero is an error'
  echo 'use return codes to identify failed assertions'
  [[ 'a' = 'a' ]] || return 1
  [[ 'a' = 'b' ]] || return 2 # test failure!
  [[ 'a' = 'c' ]] || return 3
}
test_success() {
  now="$(date +%s)"
  future=$(( now + 1 ))
  (( now < future )) || return
}
test_external_command() {
  expected_out="857691210 7"
  expected_exit=0
  cksum_out="$(cksum <<<"foobar")"
  cksum_exit=$?
  diff <(printf %s "$expected_out") <(printf %s "$cksum_out") || return 1
  [[ "$expected_exit" -eq "$cksum_exit" ]] || return "$cksum_exit"
}
. ../bashaspec.sh
