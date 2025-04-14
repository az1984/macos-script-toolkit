# root_check.zsh
#
# Confirms the script is being run as root. Exits with error if not.
#
# Function: check_if_root
#
# Arguments:
#   None
#
# Globals:
#   Uses log_error

function check_if_root() {
  if [[ "$(id -u)" -ne 0 ]]; then
    log_error "check_if_root: This script must be run as root."
    exit 1
  fi
}
