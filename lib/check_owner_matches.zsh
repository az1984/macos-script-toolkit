# check_owner_matches.zsh
#
# Returns 0 if the file owner matches the expected owner, 1 otherwise.

function check_owner_matches() {
  local file="$1"
  local expected_owner="$2"

  [[ ! -e "$file" ]] && return 1

  local actual_owner
  actual_owner=$(stat -f '%Su' "$file")

  [[ "$actual_owner" == "$expected_owner" ]] && return 0 || return 1
}
