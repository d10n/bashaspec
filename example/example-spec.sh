#!/usr/bin/env bash
cd "$(dirname "$0")" || exit 1
. ../bashaspec.sh

# Writing functions with :; at the end of
# the opening line enables empty functions.
test_empty() { :;
}

test_different_asserts() { :;
  a=foo
  b=bar
  # Use [[ for assertions. See `man test` for usage details.
  # Use return codes to identify assertion failures.
  [[ "$a" = foo ]] || return 1
  [[ "$b" = bar ]] || return 2
  [[ "$a" = "$b" ]] || return 3
  [[ "$a" != "$b" ]] || return 4
}

# Use () instead of {} to run the test in a subshell.
# This can avoid side-effects from leaking to other tests.
test_no_side_effect_bash_functions() ( :;
  # The `exec` line below causes the subshell
  # in this test to write its stderr to stdout
  exec 2>&1
  set -x
  echo ok
  false
)

test_false_assert_captures_stdout1() {
  # Stdout is suppressed for passing tests, so it is fine to write logs.
  echo foo
  # false as the last statement of a test will fail the test;
  # used here for demonstration
  false
}

test_false_assert_captures_stdout2() {
  echo bar
  false
}
