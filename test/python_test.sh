. $(dirname $0)/helper.sh

test_python_detect_source_py2() {
  has 'debian/control' 'Source: python-foo\n\nPackage:python-foo'
  check_run autodep8
  assertTrue 'get upstream name' 'grep --quiet "import foo;" stdout'
  assertTrue 'have py2 test' 'grep --quiet "python -c" stdout'
  assertFalse 'dont have py3 test' 'grep --quiet "python3 -c" stdout'
}

test_python_detect_source_py3() {
  has 'debian/control' 'Source: python-foo\n\nPackage:python3-foo'
  check_run autodep8
  assertTrue 'get upstream name' 'grep --quiet "import foo;" stdout'
  assertFalse 'dont have py2 test' 'grep --quiet "python -c" stdout'
  assertTrue 'have py3 test' 'grep --quiet "python3 -c" stdout'
}

test_python_detect_binary_py2() {
  has 'debian/control' 'Source: foo\n\nPackage: python-foo'
  check_run autodep8
  assertTrue 'get upstream name' 'grep --quiet "import foo;" stdout'
  assertTrue 'have py2 test' 'grep --quiet "python -c" stdout'
  assertFalse 'dont have py3 test' 'grep --quiet "python3 -c" stdout'
}

test_python_detect_binary_py3() {
  has 'debian/control' 'Source: foo\n\nPackage: python3-foo'
  check_run autodep8
  assertTrue 'get upstream name' 'grep --quiet "import foo;" stdout'
  assertFalse 'dont have py2 test' 'grep --quiet "python -c" stdout'
  assertTrue 'have py3 test' 'grep --quiet "python3 -c" stdout'
}

test_python_detect_binary_both() {
  has 'debian/control' 'Source: foo\n\nPackage: python-foo\n\nPackage: python3-foo'
  check_run autodep8
  assertTrue 'get upstream name' 'grep --quiet "import foo;" stdout'
  assertTrue 'have py2 test' 'grep --quiet "python -c" stdout'
  assertTrue 'have py3 test' 'grep --quiet "python3 -c" stdout'
}

test_python_ignore_doc_py2() {
  has 'debian/control' 'Source: foo\n\nPackage: python-foo-doc\n\nPackage: python-foo'
  check_run autodep8
  assertTrue 'get upstream name' 'grep --quiet "import foo;" stdout'
  assertTrue 'have py2 test' 'grep --quiet "python -c" stdout'
  assertFalse 'dont have py3 test' 'grep --quiet "python3 -c" stdout'
}

test_python_ignore_doc_py3() {
  has 'debian/control' 'Source: foo\n\nPackage: python3-foo-doc\n\nPackage: python3-foo'
  check_run autodep8
  assertTrue 'get upstream name' 'grep --quiet "import foo;" stdout'
  assertFalse 'dont have py2 test' 'grep --quiet "python -c" stdout'
  assertTrue 'have py3 test' 'grep --quiet "python3 -c" stdout'
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
