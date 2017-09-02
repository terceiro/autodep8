. $(dirname $0)/helper.sh

test_Testsuite_autopkgtest_pkg_octave() {
  has debian/control 'Testsuite: autopkgtest-pkg-octave'
  check_run autodep8
}

test_XS_Testsuite_autopkgtest_pkg_octave() {
  has debian/control 'XS-Testsuite: autopkgtest-pkg-octave'
  check_run autodep8
}

test_support_octave_detect() {
  has debian/rules 'include /usr/share/cdbs/1/class/octave-pkg.mk'
  has debian/control 'Source: octave-foo'
  has DESCRIPTION 'Name: Foo'
  check_run autodep8
}

test_no_description_file() {
  has debian/rules 'include /usr/share/cdbs/1/class/octave-pkg.mk'
  has debian/control 'Source: octave-foo'
  run autodep8
  assertEquals 1 "$exitstatus"
  assertEquals "" "$(cat stdout stderr)"
}

test_no_octave_prefix_in_source_name() {
  has debian/rules 'include /usr/share/cdbs/1/class/octave-pkg.mk'
  has debian/control 'Source: foo'
  has DESCRIPTION 'Name: Foo'
  run autodep8
  assertEquals 1 "$exitstatus"
  assertEquals "" "$(cat stdout stderr)"
}

test_no_octave_pkg_mk_in_debian_rules() {
  has debian/rules '# Nothing here'
  has debian/control 'Source: octave-foo'
  has DESCRIPTION 'Name: Foo'
  run autodep8
  assertEquals 1 "$exitstatus"
  assertEquals "" "$(cat stdout stderr)"
}

. shunit2
