# forget_pkg_receipt.zsh
#
# Forgets a package receipt using `pkgutil --forget`, if the package ID is installed.
# NOTE: This function requires root privileges to perform the forget step.
#
# Function: forget_pkg_receipt
#
# Arguments:
#   $1 - Package ID (e.g., com.microsoft.OneDrive)
#
# Globals:
#   Uses log_info, log_warn, log_error
#
# Returns:
#   0 - Success
#   1 - Error (package not found or forget failed)

function forget_pkg_receipt() {
  local pkg_id="$1"

  if [[ -z "$pkg_id" ]]; then
    log_error "forget_pkg_receipt: No package ID provided"
    return 1
  fi

  if ! pkgutil --pkgs | grep -xq "$pkg_id"; then
    log_error "forget_pkg_receipt: Package '$pkg_id' is not currently installed"
    return 1
  fi

  log_info "forget_pkg_receipt: Found package '$pkg_id' — attempting to forget (requires root)"
  pkgutil --forget "$pkg_id" >>"$LOGFILE" 2>&1
  local status=$?

  if [[ "$status" -eq 0 ]]; then
    log_info "forget_pkg_receipt: Successfully forgot '$pkg_id'"
    return 0
  else
    log_error "forget_pkg_receipt: Failed to forget '$pkg_id' (exit code $status)"
    return 1
  fi
}
