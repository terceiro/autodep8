. $(dirname $0)/helper.sh

test_no_detection() {
  run autodep8
  assertEquals 1 "$exitstatus"
}

test_append_to_control_autodep8() {
  has debian/tests/control.autodep8 '# BEFORE'
  run autodep8
  assertEquals 0 "$exitstatus"
  assertTrue 'output appended to contents of debian/tests/control.autodep8' "grep '^# BEFORE' stdout"
  assertTrue 'empty line after contents of debian/tests/control.autodep8' "grep '^\$' stdout"
}

. shunit2
