#!/usr/bin/env bash
# /* ---- 💫 https://github.com/JaKooLit 💫 ---- */  ##
# For applying Pre-configured Monitor Profiles

# Check if rofi is already running
if pidof rofi > /dev/null; then
  pkill rofi
fi

# Variables
iDIR="$HOME/.config/swaync/images"
SCRIPTSDIR="$HOME/.config/hypr/scripts"
monitor_dir="$HOME/.config/hypr/Monitor_Profiles"
target="$HOME/.config/hypr/monitors.lua"
rofi_theme="$HOME/.config/rofi/config-Monitors.rasi"
msg='❗NOTE:❗ This will overwrite $HOME/.config/hypr/monitors.lua'

# Define the list of files to ignore
ignore_files=(
  "README"
  "Previous_Profile"
)

# list of Monitor Profiles, sorted alphabetically with numbers first
mon_profiles_list=$(find -L "$monitor_dir" -maxdepth 1 -type f -name '*.lua' | sed 's/.*\///' | sed 's/\.lua$//' | sort -V)

# Remove ignored files from the list
for ignored_file in "${ignore_files[@]}"; do
    mon_profiles_list=$(echo "$mon_profiles_list" | grep -v -E "^$ignored_file$")
done

# Rofi Menu
chosen_file=$(printf '%s\n' "$mon_profiles_list" | rofi -i -dmenu -config "$rofi_theme" -mesg "$msg")

if [[ -n "$chosen_file" ]]; then
    full_path="$monitor_dir/$chosen_file.lua"

    if [[ ! -f "$full_path" ]] || ! luac -p "$full_path"; then
        notify-send -u critical -i "$iDIR/ja.png" "$chosen_file" "Invalid monitor profile"
        exit 1
    fi

    tmp_target=$(mktemp "$target.tmp.XXXXXX") || exit 1
    if ! cp -- "$full_path" "$tmp_target"; then
        rm -f -- "$tmp_target"
        notify-send -u critical -i "$iDIR/ja.png" "$chosen_file" "Failed to stage monitor profile"
        exit 1
    fi

    if [[ -f "$target" ]] && ! cp -- "$target" "$monitor_dir/Previous_Profile.lua"; then
        rm -f -- "$tmp_target"
        notify-send -u critical -i "$iDIR/ja.png" "$chosen_file" "Failed to back up current profile"
        exit 1
    fi

    if ! mv -f -- "$tmp_target" "$target"; then
        rm -f -- "$tmp_target"
        notify-send -u critical -i "$iDIR/ja.png" "$chosen_file" "Failed to install monitor profile"
        exit 1
    fi

    notify-send -u low -i "$iDIR/ja.png" "$chosen_file" "Monitor Profile Loaded"
fi

sleep 1
${SCRIPTSDIR}/RefreshNoWaybar.sh &