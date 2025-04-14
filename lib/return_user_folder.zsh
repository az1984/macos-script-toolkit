# return_user_folder.zsh
#
# Safely resolves and returns the user's home folder if it exists.
# First validates UID using dscl, then reads NFSHomeDirectory.
#
# Function: return_user_folder
#
# Arguments:
#   $1 - Username (shortname)
#
# Output:
#   Echoes home folder path to stdout
#
# Returns:
#   0 - Folder exists
#   1 - Missing, invalid, or not mappable

function return_user_folder() {
  local username="$1"

  if [[ -z "$username" ]]; then
    log_error "return_user_folder: No username provided"
    return 1
  fi

  local uid
  uid=$(get_uid_from_username "$username") || return 1

  # Validate UID
  if [[ "$uid" -lt 500 ]]; then
    log_error "return_user_folder: UID <$uid> is below threshold (500) for real users"
    return 1
  fi

  local home
  home=$(dscl . -read "/Users/$username" NFSHomeDirectory 2>/dev/null | awk '{print $2}')

  if [[ -z "$home" || ! -d "$home" ]]; then
    log_error "return_user_folder: Home folder does not exist or cannot be read for $username"
    return 1
  fi

  echo "$home"
  return 0
}
