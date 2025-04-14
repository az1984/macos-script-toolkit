# check_mode_matches.zsh
#
# Returns 0 if the file mode matches the expected octal mode (e.g. 644), 1 otherwise.

function check_mode_matches() {
  local file="$1"
  local expected_mode="$2"

  [[ ! -e "$file" ]] && return 1

  local actual_mode
  actual_mode=$(stat -f '%Lp' "$file")

  [[ "$actual_mode" == "$expected_mode" ]] && return 0 || return 1
}
