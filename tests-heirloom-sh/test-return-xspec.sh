#!/usr/heirloom/bin/sh
cd "`dirname "$0"`" || exit 1
_bashaspec_test_file="`pwd`/`basename "$0"`"

test_return_no_code_specified() {
  (exit 3) || return
  return 2
}

. ../alternate-old-versions/bashaspec-ancient.sh
