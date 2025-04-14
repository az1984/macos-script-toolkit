# kill_process.zsh
#
# Forcefully kills processes by name using `killall -9`.
# Verifies shutdown with a short poll loop and returns success/failure.
# We use -9 because it is immediate, works on GUI apps, and avoids mistaken reloads.
#
# The function performs a short wait (0.2s) after kill to catch immediate exits,
# then retries up to 5 times (1s each) only if the process is still running.
# Only logs failures if a process truly resists shutdown.
#
# Function: kill_process
#
# Arguments:
#   $1 - Name of an array variable containing process names (e.g., "Slack")
#
# Returns:
#   0 - All processes successfully terminated or not running
#   1 - One or more processes failed to terminate

function kill_process() {
  local -n procNames="$1"
  local has_failure=false

  for proc in "${procNames[@]}"; do
    if ! pgrep -ix "$proc" &>/dev/null; then
      log_info "kill_process: '$proc' is not currently running"
      continue
    fi

    log_info "kill_process: Sending killall -9 to '$proc'"
    killall -9 "$proc" 2>>"$LOGFILE"

    sleep 0.2

    if ! pgrep -ix "$proc" &>/dev/null; then
      log_info "kill_process: '$proc' terminated immediately"
      continue
    fi

    local retry=0
    while [[ "$retry" -lt 5 ]]; do
      sleep 1
      if ! pgrep -ix "$proc" &>/dev/null; then
        log_info "kill_process: '$proc' terminated after retry #$((retry + 1))"
        break
      fi
      ((retry++))
    done

    if pgrep -ix "$proc" &>/dev/null; then
      log_error "kill_process: '$proc' still running after multiple attempts"
      has_failure=true
    fi
  done

  if [[ "$has_failure" == true" ]]; then
    return 1
  else
    return 0
  fi
}
