#!/bin/zsh
#
# FUNCTEST_run_as_user.zsh
#
# Tests the run_as_user function by executing a simple command as a given user.
# It demonstrates both the standard (brief output) and the verbose mode
# (detailed debug output including stdout, stderr, and exit code).
#
# Note: This test must be run as root.
#
# Usage:
#   ./FUNCTEST_run_as_user.zsh
#

source "../../lib/run_as_user.zsh"

# Set the target user; for testing, "root" is used since it is guaranteed to exist.
TARGET_USER="root"

echo "Running in Standard Mode:"
# Standard mode: run_as_user invoked without the --verbose flag.
# Here, we use /bin/echo for simplicity.
run_as_user "$TARGET_USER" /bin/echo "Hello from run_as_user (standard)!"
exit_code_standard=$?
echo "Command was: /bin/echo \"Hello from run_as_user (standard)!\""
echo "Captured STDOUT: $run_as_user_output"
echo "Captured STDERR: $run_as_user_error"
echo "Exit Code: $exit_code_standard"

echo "\nRunning in Verbose Mode:"
# Verbose mode: pass the "--verbose" flag as the third argument.
run_as_user "$TARGET_USER" /bin/echo "Hello from run_as_user (verbose)!" --verbose
exit_code_verbose=$?
echo "Command was: /bin/echo \"Hello from run_as_user (verbose)!\" --verbose"
echo "Captured STDOUT: $run_as_user_output"
echo "Captured STDERR: $run_as_user_error"
echo "Exit Code: $exit_code_verbose"
