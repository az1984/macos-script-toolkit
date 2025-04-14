#!/bin/zsh

# FUNCTEST_check_teamid_matches.zsh
#
# Tests check_teamid_matches with:
#   FILE_0 - matching Team ID
#   FILE_1 - missing
#   FILE_2 - signed with wrong Team ID

source "../../lib/get_teamid_for_path.zsh"
source "../../lib/check_teamid_matches.zsh"

FILE_0="./env/check_teamid_matches/FILE_0"
FILE_1="./env/check_teamid_matches/FILE_1"
FILE_2="./env/check_teamid_matches/FILE_2"

EXPECTED_TEAMID="UBF8T346G9"  # Replace with valid Team ID for your test

echo "Testing FILE_0 (matching Team ID):"
check_teamid_matches "$FILE_0" "$EXPECTED_TEAMID"
echo "Exit code: $?"

echo "\nTesting FILE_1 (missing file):"
check_teamid_matches "$FILE_1" "$EXPECTED_TEAMID"
echo "Exit code: $?"

echo "\nTesting FILE_2 (wrong Team ID):"
check_teamid_matches "$FILE_2" "$EXPECTED_TEAMID"
echo "Exit code: $?"
