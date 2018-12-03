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
}

test_should_not_try_on_other_package_types_starting_with_r() {
  has 'debian/control' 'Testsuite: autopkgtest-pkg-rrrrrrr'
  run autodep8
  assertEquals 1 "$exitstatus"
  assertEquals "" "$(cat stdout stderr)"
}

test_r_recommends() {
  has debian/control 'Source: r-foo
Testsuite: autopkgtest-pkg-r

Package: r-foo-1
Recommends: r-bar

Package: r-foo-2
Recommends: r-baz'
  check_run autodep8
  cp stdout /tmp/stdout
  cp stderr /tmp/stderr
  assertTrue 'No r-bar in Depends' 'grep ^Depends: stdout | grep --quiet r-bar'
  assertTrue 'No r-baz in Depends' 'grep ^Depends: stdout | grep --quiet r-baz'
}

. shunit2
