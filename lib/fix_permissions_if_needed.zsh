# fix_permissions_if_needed.zsh
#
# Checks and individually corrects file ownership (user/group) and permissions (mode).
#
# Function: fix_permissions_if_needed
#
# Arguments:
#   $1 - Full path to file
#   $2 - Expected owner (e.g., "root" or "username")
#   $3 - Expected group (e.g., "wheel" or "staff")
#   $4 - Expected octal mode (e.g., "644" or "755")
#
# Globals:
#   Uses log_debug, log_warn

function fix_permissions_if_needed() {
  local file="$1"
  local expected_owner="$2"
  local expected_group="$3"
  local expected_mode="$4"

  if [[ ! -f "$file" ]]; then
    log_warn "fix_permissions_if_needed: File not found: $file"
    return 1
  fi

  local actual_owner actual_group actual_mode
  actual_owner=$(stat -f '%Su' "$file")
  actual_group=$(stat -f '%Sg' "$file")
  actual_mode=$(stat -f '%Lp' "$file")

  local owner_ok=false
  local group_ok=false
  local mode_ok=false

  # Check each field individually
  [[ "$actual_owner" == "$expected_owner" ]] && owner_ok=true
  [[ "$actual_group" == "$expected_group" ]] && group_ok=true
  [[ "$actual_mode" == "$expected_mode" ]] && mode_ok=true

  # Fix owner
  if [[ "$owner_ok" == false ]]; then
    log_debug "fix_permissions_if_needed: Changing owner on $file from $actual_owner to $expected_owner"
    chown "$expected_owner" "$file"
  else
    log_debug "fix_permissions_if_needed: Owner OK on $file ($actual_owner)"
  fi

  # Fix group
  if [[ "$group_ok" == false ]]; then
    log_debug "fix_permissions_if_needed: Changing group on $file from $actual_group to $expected_group"
    chgrp "$expected_group" "$file"
  else
    log_debug "fix_permissions_if_needed: Group OK on $file ($actual_group)"
  fi

  # Fix mode
  if [[ "$mode_ok" == false ]]; then
    log_debug "fix_permissions_if_needed: Changing mode on $file from $actual_mode to $expected_mode"
    chmod "$expected_mode" "$file"
  else
    log_debug "fix_permissions_if_needed: Permissions OK on $file ($actual_mode)"
  fi

  return 0
}
