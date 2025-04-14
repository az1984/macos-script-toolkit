#!/bin/zsh

# FUNCTEST_fix_permissions_if_needed.zsh
#
# Tests fix_permissions_if_needed with:
#   FILE_0 - already correct (no change)
#   FILE_1 - incorrect mode
#   FILE_2 - incorrect owner or group

source "../../lib/fix_permissions_if_needed.zsh"

FILE_0="./env/fix_permissions_if_needed/FILE_0"
FILE_1="./env/fix_permissions_if_needed/FILE_1"
FILE_2="./env/fix_permissions_if_needed/FILE_2"

EXPECTED_OWNER="root"
EXPECTED_GROUP="wheel"
EXPECTED_MODE="644"

echo "Testing FILE_0 (already correct):"
fix_permissions_if_needed "$FILE_0" "$EXPECTED_OWNER" "$EXPECTED_GROUP" "$EXPECTED_MODE"
echo "Exit code: $?"

echo "\nTesting FILE_1 (bad mode):"
fix_permissions_if_needed "$FILE_1" "$EXPECTED_OWNER" "$EXPECTED_GROUP" "$EXPECTED_MODE"
echo "Exit code: $?"

echo "\nTesting FILE_2 (bad ownership):"
fix_permissions_if_needed "$FILE_2" "$EXPECTED_OWNER" "$EXPECTED_GROUP" "$EXPECTED_MODE"
echo "Exit code: $?"
