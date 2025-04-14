# check_uid_exists.zsh
#
# Verifies that a UID exists on the system using dscl.
#
# Function: check_uid_exists
#
# Arguments:
#   $1 - UID to check
#
# Returns:
#   0 - UID exists
#   1 - UID not found or invalid

function check_uid_exists() {
  local uid="$1"

  if [[ -z "$uid" || ! "$uid" =~ '^[0-9]+$' ]]; then
    log_error "check_uid_exists: Invalid UID input: '$uid'"
    return 1
  fi

  local result
  result=$(dscl . -search /Users UniqueID "$uid" 2>/dev/null)

  if [[ -z "$result" ]]; then
    log_warn "check_uid_exists: No user found for UID $uid"
    return 1
  fi

  return 0
}
