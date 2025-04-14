# safe_delete.zsh
#
# Deletes a file or folder safely and recursively without following symlinks.
# If OPTIONAL_DELETE=true, missing files are not treated as failures.
#
# Function: safe_delete
#
# Arguments:
#   $1 - Absolute path to delete
#
# Globals:
#   LOGFILE, OPTIONAL_DELETE, log_info, log_warn, log_error, log_debug

function safe_delete() {
  local target="$1"

  if [[ -z "$target" || "$target" != /* ]]; then
    log_error "safe_delete: Invalid or empty path '$target'"
    return 1
  fi

  local canonical
  canonical="$(cd "$(dirname "$target")" 2>/dev/null && realpath "$target" 2>/dev/null)"

  if [[ -z "$canonical" || "$canonical" == "/" || "$canonical" == "/Applications" || "$canonical" == "/System"* || "$canonical" == "/Users" ]]; then
    log_error "safe_delete: Refusing dangerous path '$canonical'"
    return 1
  fi

  if [[ ! -e "$canonical" ]]; then
    if [[ "$OPTIONAL_DELETE" == true ]]; then
      log_info "safe_delete: Skipping optional target — '$canonical' not found"
      return 0
    else
      log_warn "safe_delete: Target not found: $canonical"
      return 0
    fi
  fi

  log_info "safe_delete: Deleting $canonical"

  # Internal helper to safely delete one item (file, symlink, or empty dir)
  delete_single_file_or_folder_safely() {
    [[ -L "$1" || -f "$1" ]] && rm "$1" || rmdir "$1" 2>/dev/null
  }

  if [[ -d "$canonical" ]]; then
    # Recursively list all items inside the directory (excluding the root itself),
    # and delete each one individually, working from the deepest level up.
    find -P "$canonical" -depth -mindepth 1 | while IFS= read -r item; do
      delete_single_file_or_folder_safely "$item"
    done
    delete_single_file_or_folder_safely "$canonical"
  else
    delete_single_file_or_folder_safely "$canonical"
  fi

  log_debug "safe_delete: Finished deleting $canonical"
  return 0
}
