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

. shunit2
