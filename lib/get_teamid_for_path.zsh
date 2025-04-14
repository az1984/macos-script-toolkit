# get_teamid_for_path.zsh
#
# Extracts the Team ID from a signed file or app bundle using codesign.
#
# Function: get_teamid_for_path
#
# Arguments:
#   $1 - Full path to the file/app
#
# Output:
#   Echoes the Team ID if found
#   Echoes a warning or error message otherwise
#
# Returns:
#   0 - Team ID found and echoed
#   1 - File not found
#   2 - File exists but is unsigned or missing Team ID

function get_teamid_for_path() {
  local target="$1"

  if [[ ! -e "$target" ]]; then
    echo "get_teamid_for_path: File not found: $target" >&2
    return 1
  fi

  local teamid
  teamid=$(codesign -dv --verbose=4 "$target" 2>&1 | awk -F= '/^TeamIdentifier/ { print $2 }')

  if [[ -z "$teamid" ]]; then
    echo "get_teamid_for_path: No Team ID found — file exists but may be unsigned: $target" >&2
    return 2
  fi

  echo "$teamid"
  return 0
}
