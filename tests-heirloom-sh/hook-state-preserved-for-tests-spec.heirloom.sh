#!/usr/heirloom/bin/sh
cd "`dirname "$0"`" || exit 1
_bashaspec_test_file="`pwd`/`basename "$0"`"

before_all_run=0
before_each_run=0
after_each_run=0
after_all_run=0

fake_dirs_count=1
dirs() { for i in seq 0 $fake_dirs_count; do echo $i; done; }
pushd() { fake_dirs_count=`expr "$fake_dirs_count" + 1`; }
popd() { fake_dirs_count=`expr "$fake_dirs_count" - 1`; }

before_all() {
  before_all_run=1
  pushd . # increase dir count to 2
}
after_all() {
  after_all_run=1
  popd # decrease dir count to 1
}
before_each() {
  before_each_run=1
  pushd . # increase dir count to 3
}
after_each() {
  after_each_run=1
  popd # decrease dir count to 2
}

test_1() {
  [ $before_all_run -eq 1 ] || return 1
  [ $before_each_run -eq 1 ] || return 2
  [ $after_each_run -eq 1 ] && return 4
  [ $after_all_run -eq 1 ] && return 3
  dir_count="`dirs -v | wc -l`"
  echo "dir count $dir_count should be 3"
  [ "$dir_count" -eq 3 ] || return 5
}

test_2() {
  [ $before_all_run -eq 1 ] || return 1
  [ $before_each_run -eq 1 ] || return 2
  [ $after_each_run -eq 1 ] || return 4 # after_each ran from previous test
  [ $after_all_run -eq 1 ] && return 3
  # note: test order is not guaranteed; test_2 just runs after test_1 for me
  dir_count="`dirs -v | wc -l`"
  echo "dir count $dir_count should be 3"
  [ "$dir_count" -eq 3 ] || return 5
}

. ../alternate-old-versions/bashaspec-ancient.sh
