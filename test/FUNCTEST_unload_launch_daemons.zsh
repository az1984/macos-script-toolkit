#!/bin/zsh

# FUNCTEST_unload_launch_daemons.zsh
#
# Tests unloading LaunchDaemons with:
#   DAEMONS_0 - valid plist
#   DAEMONS_1 - missing file
#   DAEMONS_2 - malformed or incorrect label

source "../../lib/unload_launch_daemons.zsh"

DAEMONS_0=("./env/unload_launch_daemons/FILE_0.plist")
DAEMONS_1=("./env/unload_launch_daemons/FILE_1.plist")
DAEMONS_2=("./env/unload_launch_daemons/FILE_2.plist")

echo "Testing DAEMONS_0 (should unload):"
unload_launch_daemons DAEMONS_0
echo "Exit code: $?"

echo "\nTesting DAEMONS_1 (missing):"
unload_launch_daemons DAEMONS_1
echo "Exit code: $?"

echo "\nTesting DAEMONS_2 (bad label or invalid plist):"
unload_launch_daemons DAEMONS_2
echo "Exit code: $?"
