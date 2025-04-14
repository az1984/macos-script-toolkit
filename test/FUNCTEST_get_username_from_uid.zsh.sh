#!/bin/zsh

# FUNCTEST_get_username_from_uid.zsh
#
# Tests get_username_from_uid with:
#   UID_0 - valid
#   UID_1 - unknown
#   UID_2 - empty

source "../../lib/get_username_from_uid.zsh"

UID_0=0
UID_1=9999
UID_2=""

echo "Testing UID_0 (should return 'root' or similar):"
get_username_from_uid "$UID_0"
echo "Exit code: $?"

echo "\nTesting UID_1 (non-existent):"
get_username_from_uid "$UID_1"
echo "Exit code: $?"

echo "\nTesting UID_2 (empty input):"
get_username_from_uid "$UID_2"
echo "Exit code: $?"
