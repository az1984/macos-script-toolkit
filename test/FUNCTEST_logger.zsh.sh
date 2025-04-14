#!/bin/zsh

# FUNCTEST_logger.zsh
#
# Tests the logger.zsh functions with fake messages.

source "../../lib/logger.zsh"

LOGFILE="./env/logger/test.log"
DEBUG=true

log_info "This is a test info message"
log_warn "This is a test warning"
log_error "This is a test error"
log_debug "This is a debug message (should appear if DEBUG=true)"

echo "Log written to $LOGFILE"
cat "$LOGFILE"
