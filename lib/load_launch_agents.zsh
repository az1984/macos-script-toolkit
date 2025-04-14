# load_launch_agents.zsh
#
# Loads LaunchAgents using launchctl bootstrap + enable with validated permissions.
#
# Arguments:
#   $1 - Name of array variable (plist paths)
#   $2 - UID
#   $3 - (optional) --verbose
#
# Globals:
#   Uses: log_info, log_warn, log_error, log_debug, fix_permissions_if_needed

function load_launch_agents() {
  local -n plist_array="$1"
  local uid="$2"
  local verbosity="$3"
  local has_error=false
  local VERBOSE_OUTPUT=false

  if [[ "$verbosity" == "--verbose" ]]; then
    VERBOSE_OUTPUT=true
  fi

  if [[ -z "$uid" || ! "$uid" =~ '^[0-9]+$' || "$uid" -lt 500 ]]; then
    log_error "load_launch_agents: Invalid UID: '$uid'"
    return 1
  fi

  if ! check_uid_exists "$uid"; then
    log_error "load_launch_agents: No user found for UID $uid"
    return 1
  fi

  local username
  username=$(dscl . -search /Users UniqueID "$uid" | awk '{print $1}')

  for plist in "${plist_array[@]}"; do
    if [[ ! -f "$plist" ]]; then
      log_warn "load_launch_agents: LaunchAgent '$plist' not found"
      continue
    fi

    local label
    label=$(defaults read "$plist" Label 2>/dev/null)

    if [[ -z "$label" ]]; then
      log_error "load_launch_agents: Could not extract Label from '$plist'"
      has_error=true
      continue
    fi

    # Permissions: user agents vs /Library/LaunchAgents
    if [[ "$plist" == /Library/LaunchAgents/* ]]; then
      fix_permissions_if_needed "$plist" "root" "wheel" "644"
    else
      fix_permissions_if_needed "$plist" "$username" "staff" "644"
    fi

    # Bootstrap
    local bootstrap_output
    bootstrap_output=$(launchctl bootstrap "gui/$uid" "$plist" 2>&1)
    local bootstrap_status=$?

    if [[ "$bootstrap_status" -eq 0 ]]; then
      log_info "load_launch_agents: Successfully bootstrapped $label"
      [[ "$VERBOSE_OUTPUT" == true ]] && echo "[bootstrap output] $bootstrap_output"
    else
      log_error "load_launch_agents: Failed to bootstrap $label — output: $bootstrap_output"
      [[ "$VERBOSE_OUTPUT" == true ]] && echo "[bootstrap error] $bootstrap_output"
      has_error=true
      continue
    fi

    # Enable
    local enable_output
    enable_output=$(launchctl enable "gui/$uid/$label" 2>&1)
    local enable_status=$?

    if [[ "$enable_status" -eq 0 ]]; then
      log_info "load_launch_agents: Successfully enabled $label"
      [[ "$VERBOSE_OUTPUT" == true ]] && echo "[enable output] $enable_output"
    else
      log_warn "load_launch_agents: Failed to enable $label — output: $enable_output"
      [[ "$VERBOSE_OUTPUT" == true ]] && echo "[enable error] $enable_output"
    fi
  done

  [[ "$has_error" == true ]] && return 1 || return 0
}
