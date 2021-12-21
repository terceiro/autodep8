. $(dirname $0)/helper.sh

test_pybuild() {
  has 'debian/control' 'Source: python-foo\n\nPackage:python3-foo\nTestsuite: autopkgtest-pkg-pybuild'
  check_run autodep8
  assertTrue 'runs pybuild-autopkgtest' 'grep "Test-Command: pybuild-autopkgtest" stdout'
  assertTrue 'sets test name' 'grep "Features:.*test-name=" stdout'
}

test_extra_depends() {
  has 'debian/control' 'Source: python-foo\n\nPackage:python3-foo\nTestsuite: autopkgtest-pkg-pybuild'
  has 'debian/tests/autopkgtest-pkg-pybuild.conf' 'extra_depends=foobar'
  check_run autodep8
  assertTrue 'uses extra depends' 'grep "Depends:.*, foobar" stdout'
}

test_extra_restrictions() {
  has 'debian/control' 'Source: python-foo\n\nPackage:python3-foo\nTestsuite: autopkgtest-pkg-pybuild'
  has 'debian/tests/autopkgtest-pkg-pybuild.conf' 'extra_restrictions=isolation-container'
  check_run autodep8
  assertTrue 'uses extra depends' 'grep "Restrictions:.*, isolation-container" stdout'
}

test_architecture() {
  has 'debian/control' 'Source: python-foo\n\nPackage:python3-foo\nTestsuite: autopkgtest-pkg-pybuild'
  has 'debian/tests/autopkgtest-pkg-pybuild.conf' 'architecture=amd64'
  check_run autodep8
  assertTrue 'uses architecture' 'grep "^Architecture: amd64$" stdout'
}

. shunit2
