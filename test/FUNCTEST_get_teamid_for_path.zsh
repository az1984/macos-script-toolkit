#!/bin/zsh

# FUNCTEST_get_teamid_for_path.zsh
#
# Tests get_teamid_for_path with real, missing, and unsigned files.

source "../../lib/get_teamid_for_path.zsh"

FILE_0="./env/get_teamid_for_path/FILE_0"  # signed and valid
FILE_1="./env/get_teamid_for_path/FILE_1"  # missing
FILE_2="./env/get_teamid_for_path/FILE_2"  # present but not signed

echo "Testing FILE_0 (should return a Team ID):"
get_teamid_for_path "$FILE_0"
echo "Exit code: $?"

echo "\nTesting FILE_1 (missing file):"
get_teamid_for_path "$FILE_1"
echo "Exit code: $?"

echo "\nTesting FILE_2 (unsigned or no Team ID):"
get_teamid_for_path "$FILE_2"
echo "Exit code: $?"
