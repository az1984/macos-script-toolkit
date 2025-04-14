#!/bin/zsh

# FUNCTEST_check_group_exists.zsh
#
# Tests check_group_exists with:
#   GROUP_0: valid group
#   GROUP_1: nonexistent group
#   GROUP_2: empty input

source "../../lib/check_group_exists.zsh"

GROUP_0="staff"     # Should exist
GROUP_1="made_up_group"  # Should not exist
GROUP_2=""

echo "Testing GROUP_0 (should exist):"
check_group_exists "$GROUP_0"
echo "Exit code: $?"

echo "\nTesting GROUP_1 (should not exist):"
check_group_exists "$GROUP_1"
echo "Exit code: $?"

echo "\nTesting GROUP_2 (empty input):"
check_group_exists "$GROUP_2"
echo "Exit code: $?"
