# check_group_matches.zsh
#
# Returns 0 if the file group matches the expected group, 1 otherwise.

function check_group_matches() {
  local file="$1"
  local expected_group="$2"

  [[ ! -e "$file" ]] && return 1

  local actual_group
  actual_group=$(stat -f '%Sg' "$file")

  [[ "$actual_group" == "$expected_group" ]] && return 0 || return 1
}
