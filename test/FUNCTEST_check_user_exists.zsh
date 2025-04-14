#!/bin/zsh

# FUNCTEST_check_user_exists.zsh
#
# Tests the check_user_exists function against three cases:
#  - USER_0: real user
#  - USER_1: clearly invalid/missing
#  - USER_2: garbage or malformed input

source "../../lib/check_user_exists.zsh"

USER_0="root"       # expected to exist
USER_1="nobodyhere" # expected to not exist
USER_2=""           # empty

echo "Testing USER_0 (should exist):"
check_user_exists "$USER_0"
echo "Exit code: $?"

echo "\nTesting USER_1 (should not exist):"
check_user_exists "$USER_1"
echo "Exit code: $?"

echo "\nTesting USER_2 (empty):"
check_user_exists "$USER_2"
echo "Exit code: $?"
