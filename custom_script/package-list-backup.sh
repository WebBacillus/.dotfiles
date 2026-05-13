#!/usr/bin/env bash
# Refreshes package list files and auto-commits changes to the dotfiles repo.

set -euo pipefail

REPO_DIR="/home/webbacillus/.dotfiles"
PKG_LIST="${REPO_DIR}/pkglist.txt"
AUR_PKG_LIST="${REPO_DIR}/aur_pkglist.txt"

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

# Stage only the package-list files
/usr/bin/git -C "$REPO_DIR" add "$PKG_LIST" "$AUR_PKG_LIST"

# Check if there are staged changes before committing
if /usr/bin/git -C "$REPO_DIR" diff --cached --quiet; then
    # No changes, nothing to commit
    exit 0
fi

# Commit with the required message
/usr/bin/git -C "$REPO_DIR" commit -m "chore: update package lists"
