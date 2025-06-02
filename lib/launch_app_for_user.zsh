# launch_app_for_user.zsh
#
# Launches a macOS GUI application as a specific user and waits
# up to 5 seconds for the process to appear.
#
# Globals:
#   DEBUG, SILENT_RUN, run_as_user_output
#
# Dependencies:
#   run_as_user (must be in path or sourced)
#   check_running (must be in path or sourced)

function launch_app_for_user() {
  local target_user="$1"
  local app_name="$2"

  if [[ -z "$target_user" || -z "$app_name" ]]; then
    [[ "$SILENT_RUN" != true ]] && log_error "launch_app_for_user: Missing username or app name"
    return 1
  fi

  [[ "$SILENT_RUN" != true ]] && log_info "Attempting to launch '$app_name' as $target_user..."

  run_as_user "$target_user" open -a "$app_name"
  local launch_exit=$?

  if [[ $launch_exit -ne 0 ]]; then
    [[ "$SILENT_RUN" != true ]] && log_warn "Failed to initiate launch of '$app_name'"
    return $launch_exit
  fi

  # Wait up to 5 seconds for the app to appear
  local attempt=0
  local max_attempts=5
  local success=1

  while [[ $attempt -lt $max_attempts ]]; do
    sleep 1
    if check_running "$app_name"; then
      [[ "$SILENT_RUN" != true ]] && log_info "'$app_name' is now running."
      success=0
      break
    fi
    attempt=$((attempt + 1))
  done

  if [[ $success -ne 0 ]]; then
    [[ "$SILENT_RUN" != true ]] && log_error "'$app_name' did not appear to launch after 5 seconds."
  fi

  return $success
}