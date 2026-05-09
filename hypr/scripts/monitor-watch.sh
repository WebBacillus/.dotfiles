#!/bin/bash
handle() {
    case $1 in
        monitorremoved*)
            MONITORS=$(hyprctl monitors -j | jq length)
            if [ "$MONITORS" -eq 0 ]; then
                hyprctl keyword monitor "eDP-1, preferred, auto, 1"
                hyprctl dispatch dpms on eDP-1   # Wake the screen up
            fi
            ;;
    esac
}

socat - "UNIX-CONNECT:$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock" \
    | while read -r line; do handle "$line"; done
