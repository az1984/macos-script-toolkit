# quit_using_GUI.zsh
#
# Attempts to quit running apps gracefully using AppleScript.
# If the app is not running, no action is taken.
#
# Function: quit_using_GUI
#
# Arguments:
#   $1 - Name of an array variable containing app names to quit
#
# Globals:
#   Uses log_info, log_warn, log_error

function quit_using_GUI() {
  local -n appList="$1"

  for appName in "${appList[@]}"; do
    local isRunning
    isRunning=$(pgrep -ix "$appName")

    if [[ -n "$isRunning" ]]; then
      log_info "quit_using_GUI: Attempting to quit '$appName' via AppleScript"
      osascript -e "tell application \"$appName\" to quit" >>"$LOGFILE" 2>&1
    else
      log_info "quit_using_GUI: '$appName' is not running, skipping GUI quit"
    fi
  done
}
