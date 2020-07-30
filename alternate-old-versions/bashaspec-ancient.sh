#!/bin/bash
# bashaspec - MIT licensed. Copyright 2020 d10n. Feel free to copy around.
# Ancient version - all features with extra support for pre-POSIX heirloom bourne shell

# Verbose? true: TAP 12 output; false: dot per test; default false
[ "${1:-}" = -v ] || [ "${1:-}" = --verbose ] && verbose=1 || verbose=0

# Runs all the test files
run_test_files() {
  while IFS= read -r cmd; do
    [ -n "$cmd" ] || continue
    printf "${tests:+\n}%s\n" "$cmd"
    if [ $verbose -eq 1 ]; then "$cmd" -v; else "$cmd"; fi ||
     fails="`expr ${fails:-0} + 1`"; tests="`expr ${tests:-0} + 1`"
  done <<EOF
`find . -perm -a=x -type f -name '*-spec.sh'`
EOF
  printf "${tests:+\n}%s\n" "`expr ${tests:-0} - ${fails:-0}` of `expr ${tests:-0}` test files passed"
  exit "`expr ${fails:-0} '>' 0`"
}

# Runs all the test functions
# hooks: (before|after)_(all|each)
run_test_functions() {
  temp="`mktemp`" # Create a temp file for buffering test output
  test_w=3; exec 3>"$temp" # Open a write file descriptor
  test_r=4; exec 4<"$temp" # Open a read file descriptor
  rm -- "$temp" # Remove the file. The file descriptors remain open and usable.
  echo "1..`printf '%s\n' "$fns" | grep -c '^test_'`"
  test_index=0; summary_code=0
  run_fn before_all >&$test_w; bail_if_fail before_all $? "`cat <&$test_r`"
  while IFS= read -r fn; do
    status=; fail=; test_index="`expr ${test_index:-0} + 1`"
    run_fn before_each >&$test_w || { status=$?; fail="$fn before_each"; }
    [ -n "$fail" ] || run_fn "$fn" >&$test_w || { status=$?; fail="$fn"; } # Skip fn if before_each failed
    run_fn after_each >&$test_w || { _s=$?; [ -n "$fail" ] || status="$_s"; fail="$fn after_each"; }
    out="`cat <&$test_r`"
    [ -z "$fail" ] || summary_code=1
    echo "${fail:+not }ok $test_index ${fail:-$fn}"
    [ -z "$fail" ] || echo "# $fail returned $status"
    { [ -z "$fail" ] && [ "$verbose" -lt 2 ]; } || [ -z "$out" ] || printf '%s\n' "$out" | sed 's/^/# /'
  done <<FN_EOF
`printf %s "$fns" | grep '^test_'`
FN_EOF
  run_fn after_all >&$test_w; bail_if_fail after_all $? "`cat <&$test_r`"
  return "$summary_code"
}

get_functions() {
  { [ -n "${BASH_VERSION:-}" ] && compgen -A function; } ||
  { [ -n "${ZSH_VERSION:-}" ] && printf '%s\n' "${(k)functions[@]}"; } ||
  awk <"$1" '
  /^[ \t]*(test_[a-zA-Z0-9_-]*|(before|after)_(all|each))[ \t]*\([ \t]*\)/{
    sub(/^[ \t]*/,"");sub(/[ \t]*\(.*/,"");print;next}
  /^[ \t]*function[ \t]*(test_[a-zA-Z0-9_-]*|(before|after)_(all|each))[ \t]*($|[({])/{
    sub(/^[ \t]*function[ \t]*/,"");sub(/[({ \t].*/,"");print;next}'
}

# Run a function if it exists.
run_fn() { if printf %s "$fns" | grep -qFx "$1"; then "$1"; fi; }

bail_if_fail() { # 1=name 2=code 3=output
  [ "$2" -eq 0 ] || {
    echo "Bail out! $1 returned $2"
    [ -z "$3" ] || printf '%s\n' "$3" | sed 's/^/# /'
    exit "$2"
  }
}

# If not verbose, format TAP generated by run_test_functions to a dot summary
format() {
  if [ "$verbose" -gt 0 ]; then awk '/^not ok/||/^Bail out!/{e=1}1;END{exit e}'; else awk '
    !head&&/1\.\.[0-9]/{sub(/^1../,"");printf "Running %s tests\n",$0}{head=1}
    /^ok/{printf ".";system("");total++;oks++;ok=1;next}
    /^not ok/{printf "x";system("");total++;not_oks++;ok=0;fail_body=0;next}
    /^Bail out!/{fail_lines[fail_line_count++]=$0;not_oks++;ok=0;fail_body=1}
    ok||/^[^#]|^$/{next}
    {sub(/^# /,"")}
    fail_body{sub(/^/,"  ")}
    {fail_lines[fail_line_count++]=$0;fail_body=1}
    END{
      printf "\n%d of %d tests passed\n",oks,total
      if(fail_line_count){printf "%d failures:\n",not_oks}
      for(i=0;i<fail_line_count;i++){printf "  %s\n",fail_lines[i]}
      if(not_oks){exit 1}
    }'
  fi
}

# This script is #!/bin/bash, so if the shell is not bash then it must have been sourced! If the shell is bash, check.
sourced=0; [ -n "${BASH_VERSION:-}" ] && eval '! (return 0 2>/dev/null)' || sourced=1
if [ "$sourced" -eq 0 ]; then
  run_test_files
else
  fns="`get_functions "${_bashaspec_test_file:-$0}"`"
  run_test_functions | format
fi
