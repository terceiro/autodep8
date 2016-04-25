. $(dirname $0)/helper.sh

test_detect_r() {
  has 'debian/control' 'Source: r-cran-foo'
  has 'DESCRIPTION' 'Package: FOO'
  check_run autodep8
}

test_upstream_name_from_description() {
  has 'debian/control' 'Source: r-cran-foo'
  has 'DESCRIPTION' 'Package: FOO'
  check_run autodep8
  assertTrue 'get package from DESCRIPTION' 'grep --quiet "library.*FOO" stdout'
}

test_should_not_try_on_other_package_types_starting_with_r() {
  has 'debian/control' 'Testsuite: autopkgtest-pkg-rrrrrrr'
  run autodep8
  assertEquals 1 "$exitstatus"
  assertEquals "" "$(cat stdout stderr)"
}

. shunit2
