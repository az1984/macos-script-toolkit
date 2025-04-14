# get_uid_from_username.zsh
#
# Returns the UID associated with a given shortname, using dscl.
#
# Function: get_uid_from_username
#
# Arguments:
#   $1 - Username (shortname)
#
# Output:
#   Echoes UID to stdout if found
#
# Returns:
#   0 - Success
#   1 - Failure

function get_uid_from_username() {
  local username="$1"

  if [[ -z "$username" ]]; then
    log_error "get_uid_from_username: No username provided"
    return 1
  fi

  local uid
  uid=$(dscl . -read "/Users/$username" UniqueID 2>/dev/null | awk '{print $2}')

  if [[ -z "$uid" || ! "$uid" =~ '^[0-9]+$' ]]; then
    log_error "get_uid_from_username: Could not determine UID for user: $username"
    return 1
  fi

  echo "$uid"
  return 0
}
