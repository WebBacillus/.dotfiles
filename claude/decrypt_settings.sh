#!/bin/sh
# Decrypts .enc.json files from this directory to ~/.claude
# Default key path: ~/.config/sops/age/keys.txt
# Use -k to override key path

set -e

DEFAULT_KEY_FILE="$HOME/.config/sops/age/keys.txt"
KEY_FILE=""
SOURCE_DIR="$(dirname "$0")"
TARGET_DIR="$HOME/.claude"

while getopts "k:h" opt; do
    case $opt in
        k) KEY_FILE="$(eval echo "$OPTARG")" ;;
        h) echo "Usage: $0 [-k PATH_TO_KEY_FILE]"
            echo "  -k  Path to age private key file (default: ~/.config/sops/age/keys.txt)"
            exit 0 ;;
        *) echo "Usage: $0 [-k PATH_TO_KEY_FILE]" >&2; exit 1 ;;
    esac
done

: "${KEY_FILE:=$DEFAULT_KEY_FILE}"

if [ ! -f "$KEY_FILE" ]; then
    echo "Error: Private key file not found at $KEY_FILE"
    exit 1
fi

# Decrypt settings
if [ -f "$SOURCE_DIR/settings.enc.json" ]; then
    SOPS_AGE_KEY_FILE="$KEY_FILE" sops --decrypt "$SOURCE_DIR/settings.enc.json" > "$TARGET_DIR/settings.json"
    echo "Decrypted settings.enc.json -> $TARGET_DIR/settings.json"
fi

# Decrypt credentials
if [ -f "$SOURCE_DIR/.credentials.enc.json" ]; then
    SOPS_AGE_KEY_FILE="$KEY_FILE" sops --decrypt "$SOURCE_DIR/.credentials.enc.json" > "$TARGET_DIR/.credentials.json"
    echo "Decrypted .credentials.enc.json -> $TARGET_DIR/.credentials.json"
fi

echo "Done."
