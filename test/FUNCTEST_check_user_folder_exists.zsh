#!/bin/zsh

# FUNCTEST_check_user_folder_exists.zsh
#
# Tests check_user_folder_exists with:
#   UID_0 - valid UID with existing home folder
#   UID_1 - UID that doesn't exist
#   UID_2 - UID with no home folder

source "../../lib/check_user_folder.zsh"

UID_0=501  # replace with an actual valid UID
UID_1=9999
UID_2=0    # adjust if needed to simulate system UID with no home

echo "Testing UID_0 (should return 0):"
check_user_folder_exists "$UID_0"
echo "Exit code: $?"

echo "\nTesting UID_1 (should return 1 — invalid UID):"
check_user_folder_exists "$UID_1"
echo "Exit code: $?"

echo "\nTesting UID_2 (system or no home folder):"
check_user_folder_exists "$UID_2"
echo "Exit code: $?"
