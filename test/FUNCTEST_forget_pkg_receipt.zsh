#!/bin/zsh

# FUNCTEST_forget_pkg_receipt.zsh
#
# Tests forget_pkg_receipt with:
#   RECEIPT_0 - real, installed receipt
#   RECEIPT_1 - non-existent or typo
#   RECEIPT_2 - empty or malformed

source "../../lib/forget_pkg_receipt.zsh"

RECEIPT_0="com.apple.pkg.Core"      # adjust to something known
RECEIPT_1="com.fake.pkg.doesnotexist"
RECEIPT_2=""

echo "Testing RECEIPT_0 (should forget):"
forget_pkg_receipt "$RECEIPT_0"
echo "Exit code: $?"

echo "\nTesting RECEIPT_1 (should fail):"
forget_pkg_receipt "$RECEIPT_1"
echo "Exit code: $?"

echo "\nTesting RECEIPT_2 (empty input):"
forget_pkg_receipt "$RECEIPT_2"
echo "Exit code: $?"
