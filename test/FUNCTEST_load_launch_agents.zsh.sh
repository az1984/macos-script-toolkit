#!/bin/zsh

# FUNCTEST_load_launch_agents.zsh
#
# Tests load_launch_agents with:
#   AGENTS_0 - valid plist path
#   AGENTS_1 - missing plist
#   AGENTS_2 - bad label or permission issues

source "../../lib/check_uid_exists.zsh"
source "../../lib/fix_permissions_if_needed.zsh"
source "../../lib/load_launch_agents.zsh"

UID="$(id -u)"  # Current user
AGENTS_0=("./env/load_launch_agents/FILE_0.plist")
AGENTS_1=("./env/load_launch_agents/FILE_1.plist")
AGENTS_2=("./env/load_launch_agents/FILE_2.plist")

echo "Testing AGENTS_0 (should succeed):"
load_launch_agents AGENTS_0 "$UID" --verbose
echo "Exit code: $?"

echo "\nTesting AGENTS_1 (missing file):"
load_launch_agents AGENTS_1 "$UID" --verbose
echo "Exit code: $?"

echo "\nTesting AGENTS_2 (bad or broken agent):"
load_launch_agents AGENTS_2 "$UID" --verbose
echo "Exit code: $?"

