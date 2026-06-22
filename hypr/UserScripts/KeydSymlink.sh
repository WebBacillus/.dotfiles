#!/usr/bin/env bash
set -euo pipefail

SOURCE="$HOME/.config/hypr/keyd.conf"
TARGET="/etc/keyd/default.conf"

if ! command -v keyd >/dev/null 2>&1; then
    echo "keyd is not installed" >&2
    exit 1
fi

if [ ! -f "$SOURCE" ]; then
    echo "Source config not found: $SOURCE" >&2
    exit 1
fi

if [ -L "$TARGET" ] && [ "$(readlink -f "$TARGET")" = "$(readlink -f "$SOURCE")" ]; then
    echo "Symlink already in place: $TARGET -> $SOURCE"
else
    sudo mkdir -p "$(dirname "$TARGET")"
    sudo ln -sfn "$SOURCE" "$TARGET"
    echo "Created symlink: $TARGET -> $SOURCE"
fi

if systemctl is-active --quiet keyd.service; then
    sudo keyd reload
    echo "keyd reloaded"
else
    echo "keyd.service is not running — start it with: sudo systemctl enable --now keyd.service"
fi
