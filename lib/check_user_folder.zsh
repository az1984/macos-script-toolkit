# check_user_folder.zsh
#
# Validates whether a given UID corresponds to a real user with a home folder.
#
# Function: check_user_folder_exists
#
# Arguments:
#   $1 - UID
#
# Returns:
#   0 - Valid user and home folder found
#   1 - Invalid or missing home folder

function check_user_folder_exists() {
  local uid="$1"

  # Validate UID
  if [[ -z "$uid" || ! "$uid" =~ '^[0-9]+$' || "$uid" -lt 500 ]]; then
    log_error "check_user_folder_exists: Invalid UID provided: '$uid'"
    return 1
  fi

  local home
  home=$(dscl . -search /Users UniqueID "$uid" | awk '{print $1}' | while read -r user; do
    dscl . -read "/Users/$user" NFSHomeDirectory 2>/dev/null | awk '{print $2}'
  done)

  if [[ -z "$home" || ! -d "$home" ]]; then
    log_warn "check_user_folder_exists: Home folder for UID $uid not found or inaccessible"
    return 1
  fi

  return 0
}
