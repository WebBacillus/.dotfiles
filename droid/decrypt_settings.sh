#!/bin/sh
# Decrypts settings.enc.json to ~/.factory/settings.json
# Default key path: ~/.config/sops/age/keys.txt
# Use -k to override key path

set -e

DEFAULT_KEY_FILE="$HOME/.config/sops/age/keys.txt"
KEY_FILE=""
ENCRYPTED_FILE="$(dirname "$0")/settings.enc.json"
OUTPUT_FILE="$HOME/.factory/settings.json"

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

if [ ! -f "$ENCRYPTED_FILE" ]; then
    echo "Error: settings.enc.json not found at $ENCRYPTED_FILE"
    exit 1
fi

SOPS_AGE_KEY_FILE="$KEY_FILE" sops --decrypt "$ENCRYPTED_FILE" > "$OUTPUT_FILE"

echo "Decrypted settings saved to $OUTPUT_FILE"
