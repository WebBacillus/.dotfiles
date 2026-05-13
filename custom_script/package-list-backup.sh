#!/usr/bin/env bash
# Refreshes package list files and auto-commits changes to the dotfiles repo.

set -euo pipefail

REPO_DIR="/home/webbacillus/.dotfiles"
PKG_LIST="${REPO_DIR}/pkg/pkglist.txt"
AUR_PKG_LIST="${REPO_DIR}/pkg/aur_pkglist.txt"

# Use safe temp files so we don't replace target files on failure
TMP_PKG_LIST=$(mktemp)
TMP_AUR_PKG_LIST=$(mktemp)

# Clean up temp files on exit
trap 'rm -f "$TMP_PKG_LIST" "$TMP_AUR_PKG_LIST"' EXIT

# Generate native explicit package list
/usr/bin/pacman -Qqen > "$TMP_PKG_LIST"

# Generate foreign/AUR explicit package list
/usr/bin/pacman -Qqem > "$TMP_AUR_PKG_LIST"

# Replace target files only after both commands succeeded
mv "$TMP_PKG_LIST" "$PKG_LIST"
mv "$TMP_AUR_PKG_LIST" "$AUR_PKG_LIST"

# Check if package-list files changed against HEAD directly
# This avoids picking up unrelated pre-staged files
if ! /usr/bin/git -C "$REPO_DIR" diff --quiet HEAD -- "$PKG_LIST" "$AUR_PKG_LIST"; then
    # Changes exist - use git commit -o to stage and commit only these files
    # git commit -o bypasses the index and stages only the specified paths
    /usr/bin/git -C "$REPO_DIR" commit -o "$PKG_LIST" "$AUR_PKG_LIST" -m "chore: update package lists"
fi
