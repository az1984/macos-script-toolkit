#!/bin/zsh

# FUNCTEST_check_uid_exists.zsh
#
# Tests check_uid_exists with:
#   UID_0 - known valid UID
#   UID_1 - made-up or out-of-range UID
#   UID_2 - empty or invalid input

source "../../lib/check_uid_exists.zsh"

UID_0=0
UID_1=99999
UID_2=""

echo "Testing UID_0 (should exist):"
check_uid_exists "$UID_0"
echo "Exit code: $?"

echo "\nTesting UID_1 (should not exist):"
check_uid_exists "$UID_1"
echo "Exit code: $?"

echo "\nTesting UID_2 (empty input):"
check_uid_exists "$UID_2"
echo "Exit code: $?"
