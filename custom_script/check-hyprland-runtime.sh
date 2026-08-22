#!/usr/bin/env bash
# Read-only smoke checks for a running Hyprland Lua session.

set -euo pipefail

if ! command -v hyprctl >/dev/null 2>&1; then
  printf 'error: hyprctl is not installed\n' >&2
  exit 1
fi

status_output=$(hyprctl status)
if ! grep -q '^configProvider: lua$' <<<"$status_output"; then
  printf 'error: the running Hyprland session is not using the Lua config provider\n' >&2
  exit 1
fi

config_errors=$(hyprctl configerrors)
if [[ -n "$config_errors" ]]; then
  printf 'error: Hyprland reports config errors:\n%s\n' "$config_errors" >&2
  exit 1
fi

binds=$(hyprctl -j binds)
for key in J K; do
  if ! jq -e --arg key "$key" 'any(.[]; .modmask == 64 and .key == $key and .dispatcher == "__lua")' <<<"$binds" >/dev/null; then
    printf 'error: required SUPER+%s Lua binding is missing\n' "$key" >&2
    exit 1
  fi
done

layout=$(hyprctl -j getoption general:layout | jq -r '.str')
case "$layout" in
  dwindle|master) ;;
  *)
    printf 'error: unexpected active layout: %s\n' "$layout" >&2
    exit 1
    ;;
esac

printf 'Hyprland Lua runtime checks passed (layout: %s).\n' "$layout"
