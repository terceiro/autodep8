. $(dirname $0)/helper.sh

test_python_detect_source_py2() {
  has 'debian/control' 'Source: python-foo\n\nPackage:python-foo'
  check_run autodep8
  assertTrue 'get upstream name' 'grep --quiet "import foo;" stdout'
  assertTrue 'have py2 test' 'grep --quiet "pyversions" stdout'
  assertFalse 'dont have py3 test' 'grep --quiet "py3versions" stdout'
}

test_python_detect_source_py3() {
  has 'debian/control' 'Source: python-foo\n\nPackage:python3-foo'
  check_run autodep8
  assertTrue 'get upstream name' 'grep --quiet "import foo;" stdout'
  assertFalse 'dont have py2 test' 'grep --quiet "pyversions" stdout'
  assertTrue 'have py3 test' 'grep --quiet "py3versions" stdout'
}

# PyPy is only Python 2 compatible for now.
test_python_detect_source_pypy() {
  has 'debian/control' 'Source: python-foo\n\nPackage:pypy-foo'
  check_run autodep8
  assertTrue 'get upstream name' 'grep --quiet "import foo;" stdout'
  assertTrue 'have pypy test' 'grep --quiet "pypy -c" stdout'
  assertFalse 'dont have py2 test' 'grep --quiet "pyversions" stdout'
  assertFalse 'dont have py3 test' 'grep --quiet "py3versions" stdout'
}

test_python_detect_binary_py2() {
  has 'debian/control' 'Source: foo\n\nPackage: python-foo'
  check_run autodep8
  assertTrue 'get upstream name' 'grep --quiet "import foo;" stdout'
  assertTrue 'have py2 test' 'grep --quiet "pyversions" stdout'
  assertFalse 'dont have py3 test' 'grep --quiet "py3versions" stdout'
}

test_python_detect_binary_py3() {
  has 'debian/control' 'Source: foo\n\nPackage: python3-foo'
  check_run autodep8
  assertTrue 'get upstream name' 'grep --quiet "import foo;" stdout'
  assertFalse 'dont have py2 test' 'grep --quiet "pyversions" stdout'
  assertTrue 'have py3 test' 'grep --quiet "py3versions" stdout'
}

test_python_detect_binary_pypy() {
  has 'debian/control' 'Source: foo\n\nPackage: pypy-foo'
  check_run autodep8
  assertTrue 'get upstream name' 'grep --quiet "import foo;" stdout'
  assertFalse 'dont have py2 test' 'grep --quiet "pyversions" stdout'
  assertFalse 'dont have py3 test' 'grep --quiet "py3versions" stdout'
  assertTrue 'have pypy test' 'grep --quiet "pypy -c" stdout'
}

test_python_detect_binary_all() {
  has 'debian/control' 'Source: foo\n\nPackage: python-foo\n\nPackage: python3-foo\n\nPackage: pypy-foo'
  check_run autodep8
  assertTrue 'get upstream name' 'grep --quiet "import foo;" stdout'
  assertTrue 'have py2 test' 'grep --quiet "pyversions" stdout'
  assertTrue 'have py3 test' 'grep --quiet "py3versions" stdout'
  assertTrue 'have pypy test' 'grep --quiet "pypy -c" stdout'
}

test_python_ignore_doc_py2() {
  has 'debian/control' 'Source: foo\n\nPackage: python-foo-doc\n\nPackage: python-foo'
  check_run autodep8
  assertTrue 'get upstream name' 'grep --quiet "import foo;" stdout'
  assertTrue 'have py2 test' 'grep --quiet "pyversions" stdout'
  assertFalse 'dont have py3 test' 'grep --quiet "py3versions" stdout'
}

test_python_ignore_doc_py3() {
  has 'debian/control' 'Source: foo\n\nPackage: python3-foo-doc\n\nPackage: python3-foo'
  check_run autodep8
  assertTrue 'get upstream name' 'grep --quiet "import foo;" stdout'
  assertFalse 'dont have py2 test' 'grep --quiet "pyversions" stdout'
  assertTrue 'have py3 test' 'grep --quiet "py3versions" stdout'
}

test_python_ignore_doc_pypy() {
  has 'debian/control' 'Source: foo\n\nPackage: pypy-foo-doc\n\nPackage: pypy-foo'
  check_run autodep8
  assertTrue 'get upstream name' 'grep --quiet "import foo;" stdout'
  assertFalse 'dont have py2 test' 'grep --quiet "pyversions" stdout'
  assertFalse 'dont have py3 test' 'grep --quiet "py3versions" stdout'
  assertTrue 'have pypy test' 'grep --quiet "pypy -c" stdout'
}

test_python_ignore_py2_non_module() {
  has 'debian/control' 'Source: python-foo\n\nPackage: python-foo-common\n\nPackage: python3-foo'
  check_run autodep8
  assertTrue 'get upstream name' 'grep --quiet "import foo;" stdout'
  assertFalse 'dont have py2 test' 'grep --quiet "pyversions" stdout'
  assertTrue 'have py3 test' 'grep --quiet "py3versions" stdout'
}

test_Testsuite_autopkgtest_pkg_python() {
  has debian/control "Testsuite: autopkgtest-pkg-python"
  check_run autodep8
}

test_XS_Testsuite_autopkgtest_pkg_python() {
  has debian/control 'XS-Testsuite: autopkgtest-pkg-python'
  check_run autodep8
}

. shunit2
