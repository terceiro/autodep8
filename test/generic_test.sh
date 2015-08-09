. $(dirname $0)/helper.sh
test_no_detection() {
  run autodep8
  assertEquals 1 "$exitstatus"
}

. shunit2
