# get_all_users.zsh
#
# Populates a global array with all local user shortnames whose UIDs are >= 500.
# Excludes system users and users without a home directory.
#
# Function: get_all_users
#
# Globals:
#   all_users — array to be populated with valid usernames
#
# Output:
#   Populates the array and logs findings

function get_all_users() {
  all_users=()  # Clear any existing contents

  # Get list of users excluding system accounts
  local raw_users
  raw_users=($(dscl . list /Users | grep -v '^_' | grep -v '^root$'))

  for user in "${raw_users[@]}"; do
    local uid
    uid=$(dscl . -read "/Users/$user" UniqueID 2>/dev/null | awk '{print $2}')

    if [[ -n "$uid" && "$uid" -ge 500 ]]; then
      all_users+=("$user")
    fi
  done
}
