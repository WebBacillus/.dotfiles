#!/bin/bash
# Replace eDP-1 with your internal monitor name
INTERNAL="eDP-1"
# Replace HDMI-1 with your external monitor name
EXTERNAL=$(xrandr | grep " connected" | grep -v "$INTERNAL" | awk '{print $1}')

if [ -z "$EXTERNAL" ]; then
    # No external monitor, enable laptop
    xrandr --output "$INTERNAL" --auto
else
    # External monitor found, disable laptop
    xrandr --output "$INTERNAL" --off --output "$EXTERNAL" --auto
fi

