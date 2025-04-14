#!/bin/zsh

# FUNCTEST_install_pkg.zsh
#
# Tests install_pkg with:
#   PKG_0 - valid .pkg (installs to /)
#   PKG_1 - missing file
#   PKG_2 - invalid or corrupted pkg

source "../../lib/install_pkg.zsh"

PKG_0="./env/install_pkg/PKG_0.pkg"
PKG_1="./env/install_pkg/PKG_1.pkg"
PKG_2="./env/install_pkg/PKG_2.pkg"

TARGET="/"  # or any custom target if testing volume mounts

echo "Testing PKG_0 (valid package):"
install_pkg "$PKG_0" "$TARGET" --verbose
echo "Exit code: $?"

echo "\nTesting PKG_1 (missing file):"
install_pkg "$PKG_1" "$TARGET" --verbose
echo "Exit code: $?"

echo "\nTesting PKG_2 (bad or invalid package):"
install_pkg "$PKG_2" "$TARGET" --verbose
echo "Exit code: $?"
