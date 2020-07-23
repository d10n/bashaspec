# bashaspec

Short, self-contained, and actually useful bash unit testing library.

There are tons of alternatives, but I was not satisfied with the ones I looked at. They tend to be one of:
* huge multi-file frameworks like bats-core. Maybe useful, but requires installation and not simple to copy around.
* dumb wrappers around `test` for natural language assertions. Too minimal to be useful.
* long single-file libraries. Better, but usually too long and not feature dense enough to be worth using.

So I wrote my own. This is a middle ground for some convenience while remaining small enough to read at a glance and to vendor the whole file as needed.

## Features

* Easy usage: just source the library, define `test_*` functions, and execute your file
* Hooks: before_all, after_all, before_each, after_each
* Assertions: no need to reinvent the wheel; just use `test`
* Output is hidden for passing tests and shown for failing tests
* Verbose and tiny output modes
* TAP compliant
* Only 80 lines total, cleanly organized into 4 functions

## Example usage

* Copy bashaspec.sh to your repository
* `myscript-spec.sh`
  ```bash
  #!/bin/bash
  . ./bashaspec.sh
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
  ```
* `./myscript-spec.sh` to run just the tests in `myscript-spec.sh` or `./bashaspec.sh` to run all test files in the directory
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

* `bashaspec.sh` produces TAP output when the VERBOSE environment variable is set to true. The TAP handling makes the script slightly longer.
* `bashaspec-non-tap.sh` is similar, but does not produce TAP output, and has marginally simpler and code.
* This readme is about as long as the actual library.

## License

MIT
