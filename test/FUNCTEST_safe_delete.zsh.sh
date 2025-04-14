#!/bin/zsh

# FUNCTEST_safe_delete.zsh
#
# Tests safe_delete with:
#   PATH_0 - valid file or folder
#   PATH_1 - does not exist
#   PATH_2 - symlink (should be unlinked, not followed)

source "../../lib/safe_delete.zsh"

PATH_0="./env/safe_delete/PATH_0"
PATH_1="./env/safe_delete/PATH_1"
PATH_2="./env/safe_delete/PATH_2"

echo "Testing PATH_0 (normal deletion):"
safe_delete "$PATH_0"
echo "Exit code: $?"

echo "\nTesting PATH_1 (missing file):"
safe_delete "$PATH_1"
echo "Exit code: $?"

echo "\nTesting PATH_2 (symlink):"
safe_delete "$PATH_2"
echo "Exit code: $?"
