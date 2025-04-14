# check_user_exists.zsh
#
# Checks if a user shortname exists on the system via dscl.
#
# Function: check_user_exists
#
# Arguments:
#   $1 - Username (shortname)
#
# Returns:
#   0 - User exists
#   1 - User does not exist or name invalid

function check_user_exists() {
  local username="$1"

  if [[ -z "$username" ]]; then
    return 1
  fi

  dscl . -read "/Users/$username" >/dev/null 2>&1
}
