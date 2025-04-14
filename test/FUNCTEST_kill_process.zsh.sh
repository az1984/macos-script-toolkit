#!/bin/zsh

# FUNCTEST_kill_process.zsh
#
# Tests kill_process by attempting to terminate real, fake, and empty processes.

source "../../lib/kill_process.zsh"

PROCESS_0="Finder"          # Should be running on macOS GUI
PROCESS_1="definitely_not_real"
PROCESS_2=""

echo "Testing PROCESS_0 (should kill if running):"
kill_process "$PROCESS_0"
echo "Exit code: $?"

echo "\nTesting PROCESS_1 (not running):"
kill_process "$PROCESS_1"
echo "Exit code: $?"

echo "\nTesting PROCESS_2 (empty input):"
kill_process "$PROCESS_2"
echo "Exit code: $?"
