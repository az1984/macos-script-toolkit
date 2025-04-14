# load_launch_daemons.zsh
#
# Loads system LaunchDaemons using launchctl bootstrap + enable.
#
# Arguments:
#   $1 - Name of array variable (plist paths)
#   $2 - (ignored)
#   $3 - (optional) --verbose
#
# Globals:
#   Uses: log_info, log_warn, log_error, fix_permissions_if_needed

function load_launch_daemons() {
  local -n plist_array="$1"
  local verbosity="$3"
  local VERBOSE_OUTPUT=false
  local has_error=false

  [[ "$verbosity" == "--verbose" ]] && VERBOSE_OUTPUT=true

  if [[ "$(id -u)" -ne 0 ]]; then
    log_error "load_launch_daemons: Must be run as root"
    return 1
  fi

  for plist in "${plist_array[@]}"; do
    if [[ ! -f "$plist" ]]; then
      log_warn "load_launch_daemons: LaunchDaemon '$plist' not found"
      continue
    fi

    local label
    label=$(defaults read "$plist" Label 2>/dev/null)

    if [[ -z "$label" ]]; then
      log_error "load_launch_daemons: Could not extract Label from '$plist'"
      has_error=true
      continue
    fi

    # Always expect root:wheel 644
    fix_permissions_if_needed "$plist" "root" "wheel" "644"

    # Bootstrap
    local bootstrap_output
    bootstrap_output=$(launchctl bootstrap system "$plist" 2>&1)
    local bootstrap_status=$?

    if [[ "$bootstrap_status" -eq 0 ]]; then
      log_info "load_launch_daemons: Successfully bootstrapped $label"
      [[ "$VERBOSE_OUTPUT" == true ]] && echo "[bootstrap output] $bootstrap_output"
    else
      log_error "load_launch_daemons: Failed to bootstrap $label — output: $bootstrap_output"
      [[ "$VERBOSE_OUTPUT" == true ]] && echo "[bootstrap error] $bootstrap_output"
      has_error=true
      continue
    fi

    # Enable
    local enable_output
    enable_output=$(launchctl enable "system/$label" 2>&1)
    local enable_status=$?

    if [[ "$enable_status" -eq 0 ]]; then
      log_info "load_launch_daemons: Successfully enabled $label"
      [[ "$VERBOSE_OUTPUT" == true ]] && echo "[enable output] $enable_output"
    else
      log_warn "load_launch_daemons: Failed to enable $label — output: $enable_output"
      [[ "$VERBOSE_OUTPUT" == true ]] && echo "[enable error] $enable_output"
    fi
  done

  [[ "$has_error" == true ]] && return 1 || return 0
}
