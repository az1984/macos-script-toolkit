# unload_launch_agents.zsh
#
# Stops and unloads per-user LaunchAgents using the `gui/<UID>` domain.
#
# Function: unload_launch_agents
#
# Arguments:
#   $1 - Name of array containing LaunchAgent plist paths
#   $2 - UID to use for unloading
#
# Globals:
#   Uses log_info, log_warn, log_error

function unload_launch_agents() {
  local -n plist_array="$1"
  local uid="$2"
  local has_error=false

  if [[ -z "$uid" || ! "$uid" =~ '^[0-9]+$' ]]; then
    log_error "unload_launch_agents: Invalid UID provided: '$uid'"
    return 1
  fi

  for plist in "${plist_array[@]}"; do
    if [[ ! -f "$plist" ]]; then
      log_warn "unload_launch_agents: LaunchAgent '$plist' not found"
      continue
    fi

    local label
    label=$(defaults read "$plist" Label 2>/dev/null)

    if [[ -z "$label" ]]; then
      log_error "unload_launch_agents: Could not extract Label from '$plist'"
      has_error=true
      continue
    fi

    log_info "unload_launch_agents: Stopping $label"
    launchctl bootout "gui/$uid" "$plist" >>"$LOGFILE" 2>&1

    if [[ $? -eq 0 ]]; then
      log_info "unload_launch_agents: Successfully unloaded $label"
    else
      log_error "unload_launch_agents: Failed to unload $label from $plist"
      has_error=true
    fi
  done

  [[ "$has_error" == true ]] && return 1 || return 0
}
