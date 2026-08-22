#!/usr/bin/env bash
# Validate the parallel Hyprland Lua configuration without starting a compositor.

set -euo pipefail

repo_dir=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)
config_dir="$repo_dir/hypr"
entrypoint="$config_dir/hyprland.lua"
wallust_config="$HOME/.config/wallust/wallust.toml"
wallust_template="$HOME/.config/wallust/templates/colors-hyprland.lua"
tracked_wallust_template="$config_dir/wallust/colors-hyprland.lua.wallust"
status=0

if [[ ! -f "$entrypoint" ]]; then
  printf 'error: Hyprland Lua entrypoint not found: %s\n' "$entrypoint" >&2
  exit 1
fi

if [[ ! -s "$wallust_template" ]] || ! grep -q '^hyprlua\.template' "$wallust_config"; then
  printf 'error: Wallust Lua template integration is not installed\n' >&2
  exit 1
fi

if ! cmp -s "$tracked_wallust_template" "$wallust_template"; then
  printf 'error: installed Wallust Lua template differs from the tracked template\n' >&2
  exit 1
fi

runtime_mutation_files=(
  "$config_dir/scripts/ChangeBlur.sh"
  "$config_dir/scripts/GameMode.sh"
  "$config_dir/scripts/ChangeLayout.sh"
  "$config_dir/scripts/KeybindsLayoutInit.sh"
  "$config_dir/scripts/TouchPad.sh"
  "$config_dir/scripts/monitor-watch.sh"
  "$config_dir/configs/SystemSettings.lua"
)

for runtime_file in "${runtime_mutation_files[@]}"; do
  if grep -nE 'hyprctl[[:space:]]+keyword|^[[:space:]]*keyword[[:space:]]' "$runtime_file" >&2; then
    printf 'error: Lua-incompatible hyprctl keyword mutation remains in %s\n' "$runtime_file" >&2
    status=1
  fi
done

if grep -qE 'general:layout[[:space:]]+hy3|layout[[:space:]]*=[[:space:]]*["'\'']?hy3' "$config_dir/scripts/ChangeLayout.sh"; then
  printf 'error: layout switcher still targets the unloaded hy3 layout\n' >&2
  status=1
fi

if ! grep -Fq 'hl.bind(mainMod .. " + J"' "$config_dir/configs/Keybinds.lua" ||
   ! grep -Fq 'hl.bind(mainMod .. " + K"' "$config_dir/configs/Keybinds.lua"; then
  printf 'error: Lua config does not register static SUPER+J/K cycle bindings\n' >&2
  status=1
fi

if ! grep -Fq 'hl.on("monitor.removed"' "$config_dir/UserConfigs/MonitorRecovery.lua" 2>/dev/null; then
  printf 'error: Lua monitor removal recovery handler is missing\n' >&2
  status=1
fi

while IFS= read -r -d '' lua_file; do
  if ! luac -p "$lua_file"; then
    printf 'error: Lua syntax check failed: %s\n' "$lua_file" >&2
    status=1
  fi
done < <(find "$config_dir" -type f -name '*.lua' -print0)

if (( status != 0 )); then
  exit "$status"
fi

Hyprland --verify-config -c "$entrypoint"
