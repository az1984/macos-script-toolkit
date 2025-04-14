#!/bin/zsh

# FUNCTEST_return_user_folder.zsh
#
# Tests return_user_folder with:
#   USER_0 - valid shortname
#   USER_1 - fake user
#   USER_2 - empty input

source "../../lib/return_user_folder.zsh"

USER_0="root"
USER_1="notarealuser"
USER_2=""

echo "Testing USER_0 (valid user):"
return_user_folder "$USER_0"
echo "Exit code: $?"

echo "\nTesting USER_1 (nonexistent user):"
return_user_folder "$USER_1"
echo "Exit code: $?"

echo "\nTesting USER_2 (empty):"
return_user_folder "$USER_2"
echo "Exit code: $?"
