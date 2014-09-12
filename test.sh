#!/bin/sh

test_ruby_rake() {
  has debian/ruby-tests.rake
  run autodep8
}

test_ruby_testrb() {
  has debian/ruby-tests.rb
  run autodep8
}

test_ruby_test_files() {
  has debian/ruby-test-files.yaml
  run autodep8
}

test_ruby_no_debhelper() {
  has debian/ruby-tests.rake
  has debian/control "Build-Depends: debhelper, gem2deb, rake"
  run autodep8
  assertFalse "test does must not depend on debhelper\n$(grep Depends: stdout)\n" "grep -q Depends:.*debhelper stdout"
}

test_ruby_no_gem2deb() {
  has debian/ruby-tests.rake
  has debian/control "Build-Depends: debhelper, gem2deb, rake"
  run autodep8
  assertFalse "test does must not depend on gemdeb\n$(grep Depends: stdout)\n" "grep -q 'Depends:.*gem2deb(\s\|,)' stdout"
}

test_ruby_gem2deb_test_runner() {
  has debian/ruby-tests.rb
  run autodep8
  assertTrue "test depends on gem2deb-test-runner\n$(grep Depends: stdout)\n" 'grep Depends:.*gem2deb-test-runner stdout'
}

test_perl_Makefile_PL() {
  has_dir t
  has Makefile.PL
  run autodep8
}

test_perl_Build_PL() {
  has_dir t
  has Build.PL
  run autodep8
}

test_detect_nodejs() {
  has 'debian/control' 'Source: node-foo'
  run autodep8
}

test_nodejs_upstream_name() {
  has 'debian/control' 'Source: node-foo'
  run autodep8
  assertTrue 'get the upstream from node package' 'grep --quiet "require.*foo" stdout'
  assertFalse 'does not include node- prefix' 'grep --quiet node-foo stdout'
}

##################################################

if [ -z "$ADTTMP" ]; then
  export PATH="$(readlink -f $(dirname $0)):$PATH"
fi

run() {
  exitstatus=0
  "$@" > stdout 2> stderr || exitstatus=$?
  assertEquals "$1 failed!\n$(tail -n 10000 stderr stdout;)\n" 0 "$exitstatus"
}

has() {
  file="$1"
  shift
  mkdir -p $(dirname "$file")
  if [ $# -gt 0 ]; then
    echo "$@" > "$file"
  else
    touch "$file"
  fi
}

has_dir() {
  mkdir -p "$@"
}

show() {
  tail -n 100000 "$@"
}

setUp() {
  tmpdir=$(mktemp -d)
  cd "$tmpdir"
}

origdir=$(pwd)
tearDown() {
  cd "$origdir"
  rm -rf "$tmpdir"
}

. shunit2
