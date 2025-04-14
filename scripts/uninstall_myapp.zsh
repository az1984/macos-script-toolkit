#!/bin/zsh

# ----------------------
# Uninstall Script: MyApp
# ----------------------

# --- Config ---
DEBUG=true
LOG_NAME="uninstall_myapp"
ABSOLUTE_LIB_PATH=false  # Set to true if using deployed version

# --- Resolve LIB_ROOT ---
if [[ "$ABSOLUTE_LIB_PATH" == true ]]; then
  LIB_ROOT="/tmp/my_package/lib"
else
  LIB_ROOT="${0:A:h}/../lib"
fi

# --- Source helpers ---
source "$LIB_ROOT/logger.zsh"
source "$LIB_ROOT/kill_process.zsh"
source "$LIB_ROOT/unload_launch_agents.zsh"
source "$LIB_ROOT/safe_delete.zsh"
source "$LIB_ROOT/forget_pkg_receipt.zsh"
source "$LIB_ROOT/get_all_users.zsh"
source "$LIB_ROOT/get_uid_from_username.zsh"
source "$LIB_ROOT/return_user_folder.zsh"

# -------------------------
# Define items for removal
# -------------------------

processesToKill=("MyApp")

launchAgentsToRemove=(
  "/Library/LaunchAgents/com.example.myApp.plist"
)
launchAgentUserUID=501  # Adjust if needed

pathsToDelete=(
  "/Applications/MyApp.app"
  "/Library/Preferences/com.myapp.plist"
)

userFolderFiles=(
  "Library/Application Support/MyApp"
  "Library/Preferences/com.myapp.plist"
)

packageReceipts=("com.example.myApp")

# -------------------------
# Step 1: Kill background processes
# -------------------------
kill_process processesToKill

# -------------------------
# Step 2: Unload LaunchAgents
# -------------------------
unload_launch_agents launchAgentsToRemove "$launchAgentUserUID"

# -------------------------
# Step 3: Delete LaunchAgents
# -------------------------
for plist in "${launchAgentsToRemove[@]}"; do
  safe_delete "$plist"
done

# -------------------------
# Step 4: Delete global system paths
# -------------------------
for path in "${pathsToDelete[@]}"; do
  safe_delete "$path"
done

# -------------------------
# Step 5: Delete per-user files
# -------------------------
log_info "Scanning local users for user-specific data removal..."
all_users=()
get_all_users

OPTIONAL_DELETE=true
for username in "${all_users[@]}"; do
  home_dir=$(return_user_folder "$username") || continue

  for rel_path in "${userFolderFiles[@]}"; do
    full_path="$home_dir/$rel_path"
    safe_delete "$full_path"
  done
done
OPTIONAL_DELETE=false

# -------------------------
# Step 6: Forget package receipts
# -------------------------
for pkgID in "${packageReceipts[@]}"; do
  forget_pkg_receipt "$pkgID"
done

# -------------------------
# Step 7: Self-check — global paths
# -------------------------
log_info "Verifying global paths were successfully removed..."
for path in "${pathsToDelete[@]}"; do
  if [[ -e "$path" ]]; then
    log_error "self-check: FAILED — '$path' still exists after deletion attempt"
  else
    log_info "self-check: OK — '$path' successfully removed"
  fi
done

# -------------------------
# Step 8: Self-check — user files
# -------------------------
OPTIONAL_DELETE=true
for username in "${all_users[@]}"; do
  home_dir=$(return_user_folder "$username") || continue

  for rel_path in "${userFolderFiles[@]}"; do
    full_path="$home_dir/$rel_path"
    if [[ -e "$full_path" ]]; then
      log_warn "self-check: User file not removed: $full_path"
    else
      log_info "self-check: OK — $full_path removed (or not present)"
    fi
  done
done
OPTIONAL_DELETE=false
