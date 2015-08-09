. $(dirname $0)/helper.sh

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

test_Testsuite_autopkgtest_pkg_nodejs() {
  has debian/control 'Testsuite: autopkgtest-pkg-nodejs'
  check_run autodep8
}

test_XS_Testsuite_autopkgtest_pkg_nodejs() {
  has debian/control 'XS-Testsuite: autopkgtest-pkg-nodejs'
  check_run autodep8
}

. shunit2
