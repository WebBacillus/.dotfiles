#!/usr/bin/env bash
# /* ---- 💫 https://github.com/JaKooLit 💫 ---- */  ##
# Game Mode. Turning off all animations

notif="$HOME/.config/swaync/images/ja.png"
SCRIPTSDIR="$HOME/.config/hypr/scripts"


HYPRGAMEMODE=$(hyprctl getoption animations:enabled | awk 'NR==1{print $2}')
if [ "$HYPRGAMEMODE" = 1 ] ; then
    hyprctl eval 'hl.config({ animations = { enabled = false }, decoration = { shadow = { enabled = false }, blur = { enabled = false }, rounding = 0 }, general = { gaps_in = 0, gaps_out = 0, border_size = 1 } }); hl.window_rule({ name = "game-mode-opacity", match = { class = "^(.*)$" }, opacity = "1 override 1 override 1 override" })'
    awww kill
    pkill -SIGUSR1 waybar
    notify-send -e -u low -i "$notif" " Gamemode:" " enabled"
    sleep 0.1
    exit
else
	if ! awww query > /dev/null 2>&1; then
		awww-daemon &
		sleep 1
	fi
	awww img "$HOME/.config/rofi/.current_wallpaper" &
	sleep 0.1
	${SCRIPTSDIR}/WallustAwww.sh
	sleep 0.5
  hyprctl reload
	${SCRIPTSDIR}/Refresh.sh	 
    notify-send -e -u normal -i "$notif" " Gamemode:" " disabled"
    exit
fi
hyprctl reload
