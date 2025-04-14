#!/bin/zsh

# FUNCTEST_unload_launch_agents.zsh
#
# Tests unloading LaunchAgents with:
#   AGENTS_0 - valid plist
#   AGENTS_1 - missing plist
#   AGENTS_2 - malformed plist or missing Label

source "../../lib/unload_launch_agents.zsh"
source "../../lib/check_uid_exists.zsh"

UID="$(id -u)"
AGENTS_0=("./env/unload_launch_agents/FILE_0.plist")
AGENTS_1=("./env/unload_launch_agents/FILE_1.plist")
AGENTS_2=("./env/unload_launch_agents/FILE_2.plist")

echo "Testing AGENTS_0 (should unload cleanly):"
unload_launch_agents AGENTS_0 "$UID"
echo "Exit code: $?"

echo "\nTesting AGENTS_1 (missing file):"
unload_launch_agents AGENTS_1 "$UID"
echo "Exit code: $?"

echo "\nTesting AGENTS_2 (bad or malformed plist):"
unload_launch_agents AGENTS_2 "$UID"
echo "Exit code: $?"
