# logger.zsh
#
# Basic logging framework with timestamps. Supports quiet/verbose modes and debug logging.

function log_info() {
  echo "$(date '+%Y-%m-%d %H:%M:%S') [INFO] $*" >> "$LOGFILE"
}

function log_warn() {
  echo "$(date '+%Y-%m-%d %H:%M:%S') [WARN] $*" >> "$LOGFILE"
}

function log_error() {
  echo "$(date '+%Y-%m-%d %H:%M:%S') [ERROR] $*" >> "$LOGFILE"
}

function log_debug() {
  [[ "$DEBUG" == true ]] && echo "$(date '+%Y-%m-%d %H:%M:%S') [DEBUG] $*" >> "$LOGFILE"
}
