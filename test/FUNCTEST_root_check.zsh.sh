#!/bin/zsh

# FUNCTEST_root_check.zsh
#
# Tests check_if_root. Must be run as root to pass.

source "../../lib/root_check.zsh"

check_if_root
echo "Exit code: $?"
