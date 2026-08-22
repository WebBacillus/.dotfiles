#!/bin/bash
handle() {
    case $1 in
        monitorremoved*)
            MONITORS=$(hyprctl monitors -j | jq length)
            if [ "$MONITORS" -eq 0 ]; then
                hyprctl eval 'hl.monitor({ output = "eDP-1", mode = "preferred", position = "auto", scale = 1, disabled = false })'
                hyprctl dispatch dpms on eDP-1   # Wake the screen up
            fi
            ;;
    esac
}

socat - "UNIX-CONNECT:$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock" \
    | while read -r line; do handle "$line"; done
