#!/bin/zsh

# FUNCTEST_load_launch_daemons.zsh
#
# Tests load_launch_daemons with:
#   DAEMONS_0 - valid daemon plist
#   DAEMONS_1 - missing file
#   DAEMONS_2 - malformed or broken

source "../../lib/fix_permissions_if_needed.zsh"
source "../../lib/load_launch_daemons.zsh"

DAEMONS_0=("./env/load_launch_daemons/FILE_0.plist")
DAEMONS_1=("./env/load_launch_daemons/FILE_1.plist")
DAEMONS_2=("./env/load_launch_daemons/FILE_2.plist")

echo "Testing DAEMONS_0 (valid daemon):"
load_launch_daemons DAEMONS_0 "" --verbose
echo "Exit code: $?"

echo "\nTesting DAEMONS_1 (missing file):"
load_launch_daemons DAEMONS_1 "" --verbose
echo "Exit code: $?"

echo "\nTesting DAEMONS_2 (invalid plist):"
load_launch_daemons DAEMONS_2 "" --verbose
echo "Exit code: $?"
