#!/bin/zsh

# FUNCTEST_get_all_users.zsh
#
# Tests get_all_users by printing out the result array.
# No inputs. Should return shortnames for local users with UID ≥ 500.

source "../../lib/get_all_users.zsh"

all_users=()
get_all_users

echo "All detected users:"
for user in "${all_users[@]}"; do
  echo "- $user"
done
