# check_teamid_matches.zsh
#
# Compares expected Team ID against what get_teamid_for_path returns.
#
# Function: check_teamid_matches
#
# Arguments:
#   $1 - Full path to file
#   $2 - Expected Team ID
#
# Returns:
#   0 - Team ID matches
#   1 - Mismatch or invalid

function check_teamid_matches() {
  local target="$1"
  local expected="$2"

  local actual
  actual=$(get_teamid_for_path "$target") || return 1

  [[ "$actual" == "$expected" ]] && return 0 || return 1
}
