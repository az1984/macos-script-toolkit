# run_as_user.zsh
#
# Runs a command as a specified user using launchctl + sudo,
# capturing stdout, stderr, and exit code.
#
# Globals:
#   run_as_user_output - captured stdout
#   run_as_user_error  - captured stderr
#   DEBUG              - if true, prints all details
#   SILENT_RUN         - if true, suppresses all logging
#
# Returns:
#   0 on success, 1 on UID resolution failure, or actual command exit code

function run_as_user() {
  local target_user="$1"
  shift

  if [[ -z "$target_user" ]]; then
    [[ "$SILENT_RUN" != true ]] && log_error "run_as_user: No username supplied"
    return 1
  fi

  local uid
  uid=$(dscl . -read "/Users/$target_user" UniqueID 2>/dev/null | awk '{print $2}')

  if [[ -z "$uid" || ! "$uid" =~ '^[0-9]+$' || "$uid" -lt 500 ]]; then
    [[ "$SILENT_RUN" != true ]] && log_error "run_as_user: Invalid or non-login user: $target_user"
    return 1
  fi

  local command_str="$*"
  local output error exit_code

  [[ "$SILENT_RUN" != true ]] && log_debug "run_as_user: Executing as $target_user (UID $uid): $command_str"

  output=$(launchctl asuser "$uid" sudo -u "$target_user" "$@" 2> >(error=$(cat); typeset -p error >/dev/null))
  exit_code=$?

  run_as_user_output="$output"
  run_as_user_error="$error"

  if [[ "$SILENT_RUN" == true ]]; then
    return $exit_code
  fi

  if [[ "$DEBUG" == true ]]; then
    echo "run_as_user DEBUG:"
    echo "  Command: $command_str"
    echo "  STDOUT:  $run_as_user_output"
    echo "  STDERR:  $run_as_user_error"
    echo "  Exit Code: $exit_code"
  else
    echo "Command was: $command_str"
    echo "Output was: $run_as_user_output"
    if [[ $exit_code -ne 0 ]]; then
      log_warn "run_as_user: Command failed with exit code $exit_code"
    else
      log_info "run_as_user: Command succeeded"
    fi
  fi

  return $exit_code
}
