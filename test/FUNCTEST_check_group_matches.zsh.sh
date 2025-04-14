#!/bin/zsh

# FUNCTEST_check_group_matches.zsh
#
# Tests the check_group_matches function using three static test cases:
#   FILE_0 - exists, correct group
#   FILE_1 - does not exist
#   FILE_2 - exists, incorrect group

source "../../lib/check_group_matches.zsh"

FILE_0="./env/check_group_matches/FILE_0"
FILE_1="./env/check_group_matches/FILE_1"
FILE_2="./env/check_group_matches/FILE_2"

EXPECTED_GROUP="staff"  # Adjust as needed

echo "Testing FILE_0 (should match group):"
check_group_matches "$FILE_0" "$EXPECTED_GROUP"
echo "Exit code: $?"

echo "\nTesting FILE_1 (file missing):"
check_group_matches "$FILE_1" "$EXPECTED_GROUP"
echo "Exit code: $?"

echo "\nTesting FILE_2 (wrong group):"
check_group_matches "$FILE_2" "$EXPECTED_GROUP"
echo "Exit code: $?"
