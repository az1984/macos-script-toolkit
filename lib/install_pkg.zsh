# install_pkg.zsh
#
# Installs a flat .pkg using /usr/sbin/installer with -verbose,
# supports custom target, requires root, and optionally echoes output.
#
# Function: install_pkg
#
# Arguments:
#   $1 - Full path to .pkg
#   $2 - Install target (e.g., /)
#   $3 - (optional) --verbose to echo captured stdout
#
# Returns:
#   exit code from installer

function install_pkg() {
  local pkg_path="$1"
  local target="$2"
  local verbosity="$3"
  local INSTALLER_BIN="/usr/sbin/installer"

  # Require root
  if [[ "$(id -u)" -ne 0 ]]; then
    log_error "install_pkg: Must be run as root"
    return 1
  fi

  if [[ ! -f "$pkg_path" ]]; then
    log_error "install_pkg: Package not found: $pkg_path"
    return 1
  fi

  if [[ -z "$target" || ! -d "$target" ]]; then
    log_error "install_pkg: Invalid or missing target volume: $target"
    return 1
  fi

  local install_output
  install_output=$("$INSTALLER_BIN" -verbose -pkg "$pkg_path" -target "$target" 2>&1)
  local install_status=$?

  log_info "install_pkg: Installer returned exit code $install_status for $pkg_path → $target"

  if [[ "$verbosity" == "--verbose" ]]; then
    echo "$install_output"
  fi

  return $install_status
}
