# Changelog

## [Unreleased]
No unreleased changes yet

## [1.1.1] - 2021-02-15
### Fixed
* The MIT license notice at the top of bashaspec.sh now explicitly only covers the file itself. This should make it clearer that the license does not make any claim about other files in repositories that bashaspec is copied into.

## [1.1.0] - 2021-02-15
### Changed
* Stderr is now captured and suppressed for passing tests, like stdout.

## [1.0.0] - 2021-02-08
### Changed
* Documentation updates.

### Fixed
* Report 0 test runs if 0 tests ran.

## [2020-07-30]
### Changed
* bashaspec.sh must now be sourced after defining test functions.

### Fixed
* The `before_all` and `after_all` hooks now correctly report failure with `set -e`.

## [2020-07-27]
### Added
* Support for pre-POSIX heirloom bourne shell, in the alternate `bashaspec-ancient.sh` version.

## [2020-07-26]
### Changed
* Bash and zsh no longer require `_bashaspec_test_file` when changing directory outside of a test function.

### Fixed
* Zsh support: zsh has a builtin `functions` variable, so bashaspec now lists its functions in the `fns` variable instead.

## [2020-07-25]
### Added
* Support non-bash shells (like dash and ksh).
    * This update requires the `_bashaspec_test_file` variable to be set to the full path of the test file, if the test file changes directory outside of a test function.
* Support running on macs with BSD `find` / `wc`.
* Support bash 3.2 (which is the latest version of bash on macs).
* Support tests with `set -e`.
* When directly executing bashaspec.sh to run all test files, bashaspec reports the number of passing files.

### Changed
* Verbose mode is enabled with the `-v` flag instead of the VERBOSE environment variable.
* Test function and before/after hook invocation now mirror JUnit logic:
    * `before_all` runs if defined. If it fails, the file is marked as failed and exits.
    * The tests run:
        * `before_each` runs if defined. If it fails, the test is marked as failed.
        * If before_each succeeded, the main test function runs. If it fails, the test is marked as failed.
        * `after_each` runs if defined. If it fails, the test is marked as failed.
    * `after_all` runs if defined. If it fails, the file is marked as failed and exits.
  Previously, a test was marked as failed only if the main test function failed, and if before_each failed, after_each did not run.

### Fixed
* Verbose mode now correctly exits 1 if a test failed.
* The `--verbose` or `-v` flag now produces verbose output when directly executing bashaspec.sh.

## Initial release - [2020-07-23]
### Added
* bashaspec

[Unreleased]: https://github.com/d10n/bashaspec/compare/v1.1.1...HEAD
[1.1.1]: https://github.com/d10n/bashaspec/compare/v1.1.0...v1.1.1
[1.1.0]: https://github.com/d10n/bashaspec/compare/v1.0.0...v1.1.0
[1.0.0]: https://github.com/d10n/bashaspec/compare/a2390b481e9dbcc9048f72db20d41963e8417ab5...v1.0.0
[2020-07-30]: https://github.com/d10n/bashaspec/compare/ab844f2071ff0f838d0bcadaa22be36b3773d3c3...a2390b481e9dbcc9048f72db20d41963e8417ab5
[2020-07-27]: https://github.com/d10n/bashaspec/compare/41eebcd853d6f14bff1e7594559232d7be875f40...ab844f2071ff0f838d0bcadaa22be36b3773d3c3
[2020-07-26]: https://github.com/d10n/bashaspec/compare/68929d8b370e0372c2f5111787272aa87d934989...41eebcd853d6f14bff1e7594559232d7be875f40
[2020-07-25]: https://github.com/d10n/bashaspec/compare/fd1e826435f080b074ca38ab5e9b0e806db9eb50...68929d8b370e0372c2f5111787272aa87d934989
[2020-07-23]: https://github.com/d10n/bashaspec/compare/0f2f95a3674d0a906dca649255e9d3048193dfca...fd1e826435f080b074ca38ab5e9b0e806db9eb50
