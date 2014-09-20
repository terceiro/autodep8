#!/bin/sh

test_no_detection() {
  run autodep8
  assertEquals 1 "$exitstatus"
}

test_Testsuite_autopkgtest_pkg_ruby() {
  has debian/control 'Testsuite: autopkgtest-pkg-ruby'
  check_run autodep8
}

test_XS_Testsuite_autopkgtest_pkg_ruby() {
  has debian/control 'XS-Testsuite: autopkgtest-pkg-ruby'
  check_run autodep8
}

test_Testsuite_autopkgtest_pkg_perl() {
  has debian/control 'Testsuite: autopkgtest-pkg-perl'
  check_run autodep8
}

test_XS_Testsuite_autopkgtest_pkg_perl() {
  has debian/control 'XS-Testsuite: autopkgtest-pkg-perl'
  check_run autodep8
}

test_Testsuite_autopkgtest_pkg_nodejs() {
  has debian/control 'Testsuite: autopkgtest-pkg-nodejs'
  check_run autodep8
}

test_XS_Testsuite_autopkgtest_pkg_nodejs() {
  has debian/control 'XS-Testsuite: autopkgtest-pkg-nodejs'
  check_run autodep8
}

test_ruby_rake() {
  has debian/ruby-tests.rake
  check_run autodep8
}

test_ruby_testrb() {
  has debian/ruby-tests.rb
  check_run autodep8
}

test_ruby_test_files() {
  has debian/ruby-test-files.yaml
  check_run autodep8
}

test_ruby_no_debhelper() {
  has debian/ruby-tests.rake
  has debian/control "Build-Depends: debhelper, gem2deb, rake"
  check_run autodep8
  assertFalse "test does must not depend on debhelper\n$(grep Depends: stdout)\n" "grep -q Depends:.*debhelper stdout"
}

test_ruby_no_gem2deb() {
  has debian/ruby-tests.rake
  has debian/control "Build-Depends: debhelper, gem2deb, rake"
  check_run autodep8
  assertFalse "test does must not depend on gemdeb\n$(grep Depends: stdout)\n" "grep -q 'Depends:.*gem2deb(\s\|,)' stdout"
}

test_ruby_gem2deb_test_runner() {
  has debian/ruby-tests.rb
  check_run autodep8
  assertTrue "test depends on gem2deb-test-runner\n$(grep Depends: stdout)\n" 'grep Depends:.*gem2deb-test-runner stdout'
}

test_perl_Makefile_PL() {
  has_dir t
  has Makefile.PL
  check_run autodep8
}

test_perl_Build_PL() {
  has_dir t
  has Build.PL
  check_run autodep8
}

test_perl_test_pl() {
  has test.pl
  has Build.PL
  check_run autodep8
}

test_detect_nodejs() {
  has 'debian/control' 'Source: node-foo'
  check_run autodep8
}

test_nodejs_upstream_name() {
  has 'debian/control' 'Source: node-foo'
  check_run autodep8
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
}

check_run() {
  run "$@"
  assertEquals "$@ failed!\n$(tail -n 10000 stderr stdout;)\n" 0 "$exitstatus"
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
