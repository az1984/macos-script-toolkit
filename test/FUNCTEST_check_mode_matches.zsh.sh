#!/bin/zsh

# FUNCTEST_check_mode_matches.zsh
#
# Tests the check_mode_matches function using three static test cases:
#   FILE_0 - exists, correct mode
#   FILE_1 - does not exist
#   FILE_2 - exists, incorrect mode

source "../../lib/check_mode_matches.zsh"

FILE_0="./env/check_mode_matches/FILE_0"
FILE_1="./env/check_mode_matches/FILE_1"
FILE_2="./env/check_mode_matches/FILE_2"

EXPECTED_MODE="644"  # Adjust as needed

echo "Testing FILE_0 (should match mode):"
check_mode_matches "$FILE_0" "$EXPECTED_MODE"
echo "Exit code: $?"

echo "\nTesting FILE_1 (file missing):"
check_mode_matches "$FILE_1" "$EXPECTED_MODE"
echo "Exit code: $?"

echo "\nTesting FILE_2 (wrong mode):"
check_mode_matches "$FILE_2" "$EXPECTED_MODE"
echo "Exit code: $?"
