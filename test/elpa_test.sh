. $(dirname $0)/helper.sh

test_Testsuite_autopkgtest_pkg_elpa() {
  has debian/control 'Testsuite: autopkgtest-pkg-elpa'
  check_run autodep8
}

test_XS_Testsuite_autopkgtest_pkg_elpa() {
  has debian/control 'XS-Testsuite: autopkgtest-pkg-elpa'
  check_run autodep8
}

test_elpa_test_ert() {
  has debian/control 'Build-Depends: dh-elpa'
  has debian/rules 'foo'
  has test.el '(ert-deftest foo)'
  check_run autodep8
}

test_elpa_test_buttercup() {
  has debian/control 'Build-Depends: dh-elpa, elpa-buttercup'
  has debian/rules 'foo'
  check_run autodep8
}

test_elpa_test_disabled() {
  has debian/control 'Build-Depends: dh-elpa, elpa-buttercup'
  has debian/rules 'export DH_ELPA_TEST_DISABLE'
  run autodep8
  assertEquals 1 "$exitstatus"
  assertEquals "" "$(cat stdout stderr)"
}

test_elpa_test_non_elpa() {
  has debian/control 'Build-Depends: dh-fake-elpa, elpa-buttercup'
  has debian/rules 'foo'
  run autodep8
  assertEquals 1 "$exitstatus"
  assertEquals "" "$(cat stdout stderr)"
}

. shunit2
