#!/bin/zsh

# FUNCTEST_get_uid_from_username.zsh
#
# Tests get_uid_from_username with:
#   USER_0 - valid shortname
#   USER_1 - fake
#   USER_2 - empty

source "../../lib/get_uid_from_username.zsh"

USER_0="root"
USER_1="notarealuser"
USER_2=""

echo "Testing USER_0 (should return UID):"
get_uid_from_username "$USER_0"
echo "Exit code: $?"

echo "\nTesting USER_1 (invalid):"
get_uid_from_username "$USER_1"
echo "Exit code: $?"

echo "\nTesting USER_2 (empty input):"
get_uid_from_username "$USER_2"
echo "Exit code: $?"
