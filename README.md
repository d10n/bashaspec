# bashaspec

Short, self-contained, and actually useful unit testing library for bash, zsh, ksh, dash, and sh.

There are tons of alternatives, but I was not satisfied with the ones I looked at. They tend to be one of:
* huge multi-file frameworks like bats-core. Maybe useful, but requires installation and not simple to copy around.
* dumb wrappers around the `test` command for natural language assertions. Too minimal to be useful.
* long single-file libraries. Better, but usually too long and not feature dense enough for my taste.

So I wrote my own. This is a middle ground for some convenience while remaining small enough to read at a glance and to vendor the whole file as needed.

## Features

* Easy usage: just source the library after defining `test_*` functions, and execute your file
* Hooks: before_all, after_all, before_each, after_each
* Assertions: no need to reinvent the wheel; just use the `test` or `[[ ]]` commands
* Output is hidden for passing tests and shown for failing tests
* Verbose and tiny output modes
* Test Anything Protocol (TAP) compliant
* Less than 100 lines total, cleanly organized into a few functions
* Support for tests written in other non-bash POSIX shells, like dash!

## Example usage

* Copy bashaspec.sh to your repository
* `myscript-spec.sh`
  ```bash
  #!/bin/bash
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
    echo 'use return codes to identify failed assertions'
    [[ 'a' = 'a' ]] || return 1
    [[ 'a' = 'b' ]] || return 2 # causes return 2!
    [[ 'a' = 'c' ]] && return 3
  }
  test_a_success() {
    now="$(date +%s)"
    future=$((now+1))
    (( now < future )) || return 1
  }
  . ./bashaspec.sh
  ```
* `./myscript-spec.sh` to run just the tests in `myscript-spec.sh` or `./bashaspec.sh` to run all test files in the current directory, recursively
  ```bash
  [user@host ~]$ ./myscript-spec.sh
  Running 4 tests
  ..x.
  3 of 4 tests passed
  Failures:
    test_an_error returned 2
      returning nonzero is an error
      use return codes to identify failed assertions
  ```

## Notes

* There is not a standard for listing defined functions. bashaspec has special cases for bash and zsh, but in other shells, bashaspec will scan the test file for test functions.  
  When using other shells, if your test script changes directory (`cd`) outside of a test function, bashaspec needs to be told the path of the test file by setting the `_bashaspec_test_file` variable.  
  For example:
  ```bash
  #!/bin/dash
  cd "$(dirname "$0")" || exit 1
  _bashaspec_test_file="$(pwd)/$(basename "$0")"
  test_foo() { : ... ; }
  . ../bashaspec.sh
  ```
* `bashaspec.sh` produces TAP output when given the `-v` or `--verbose` argument. The TAP handling makes the script slightly longer than the original non-tap version, but the main bashaspec.sh version is better anyway, so you should use this.
* `bashaspec-non-posix.sh` only supports tests written in bash, and is kept for reference. You probably want to just use bashaspec.sh.
* `bashaspec-non-tap.sh` is similar, but does not produce TAP output, and has marginally simpler code. Historical; prefer bashaspec.sh for regular usage.
* `bashaspec-ancient.sh` has all bashaspec.sh features, but additionally supports tests written in pre-posix relics like heirloom shell, at the cost of using backticks instead of $(), and at the cost of shelling out to expr to perform arithmetic operations. Do you really need this version? You probably want to just use bashaspec.sh.
* This readme is about as long as the actual library.

## License

MIT
