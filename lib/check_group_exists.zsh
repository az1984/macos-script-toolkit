# check_group_exists.zsh
#
# Checks if a group exists on the system via dscl.
#
# Function: check_group_exists
#
# Arguments:
#   $1 - Group name
#
# Returns:
#   0 - Group exists
#   1 - Group does not exist or name invalid

function check_group_exists() {
  local groupname="$1"

  if [[ -z "$groupname" ]]; then
    return 1
  fi

  dscl . -read "/Groups/$groupname" >/dev/null 2>&1
}
