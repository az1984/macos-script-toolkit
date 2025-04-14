# unload_launch_daemons.zsh
#
# Stops and unloads LaunchDaemons using the 'system' domain.
# Requires root privileges.
#
# Function: unload_launch_daemons
#
# Arguments:
#   $1 - Name of array containing LaunchDaemon plist paths
#
# Globals:
#   Uses log_info, log_warn, log_error

function unload_launch_daemons() {
  local -n plist_array="$1"
  local has_error=false

  # Check for root
  if [[ "$(id -u)" -ne 0 ]]; then
    log_error "unload_launch_daemons: This action requires root"
    return 1
  fi

  for plist in "${plist_array[@]}"; do
    if [[ ! -f "$plist" ]]; then
      log_warn "unload_launch_daemons: LaunchDaemon '$plist' not found"
      continue
    fi

    local label
    label=$(defaults read "$plist" Label 2>/dev/null)

    if [[ -z "$label" ]]; then
      log_error "unload_launch_daemons: Could not extract Label from '$plist'"
      has_error=true
      continue
    fi

    log_info "unload_launch_daemons: Stopping $label"
    launchctl bootout system "$plist" >>"$LOGFILE" 2>&1

    if [[ $? -eq 0 ]]; then
      log_info "unload_launch_daemons: Successfully unloaded $label"
    else
      log_error "unload_launch_daemons: Failed to unload $label from $plist"
      has_error=true
    fi
  done

  [[ "$has_error" == true ]] && return 1 || return 0
}
