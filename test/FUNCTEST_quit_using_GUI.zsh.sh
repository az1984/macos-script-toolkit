#!/bin/zsh

# FUNCTEST_quit_using_GUI.zsh
#
# Tests quit_using_GUI with:
#   PROCESS_0 - a running GUI app
#   PROCESS_1 - a non-existent app
#   PROCESS_2 - empty input

source "../../lib/quit_using_GUI.zsh"

PROCESS_0="TextEdit"   # Launch manually before running
PROCESS_1="NoSuchApp"
PROCESS_2=""

echo "Testing PROCESS_0 (should quit GUI app):"
quit_using_GUI "$PROCESS_0"
echo "Exit code: $?"

echo "\nTesting PROCESS_1 (app not running):"
quit_using_GUI "$PROCESS_1"
echo "Exit code: $?"

echo "\nTesting PROCESS_2 (empty input):"
quit_using_GUI "$PROCESS_2"
echo "Exit code: $?"
