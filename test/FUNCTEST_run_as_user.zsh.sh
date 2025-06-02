#!/bin/zsh

# FUNCTEST_run_as_user.zsh
#
# Tests the run_as_user function with:
#   USER_0 - valid shortname with a login session
#   USER_1 - invalid or non-existent user
#   USER_2 - empty input
#
# NOTE: You must be root to run this test.

source "../../lib/run_as_user.zsh"

USER_0="your_real_username_here"  # replace with an actual shortname on your system
USER_1="definitely_not_real"
USER_2=""

echo "Testing USER_0 (should succeed):"
run_as_user "$USER_0" whoami
echo "Exit code: $?"
echo ""

echo "Testing USER_1 (invalid user):"
run_as_user "$USER_1" whoami
echo "Exit code: $?"
echo ""

echo "Testing USER_2 (empty input):"
run_as_user "$USER_2" whoami
echo "Exit code: $?"