#!/usr/bin/env bash
# /* ---- 💫 https://github.com/JaKooLit 💫 ---- */  ##
# for changing Hyprland Layouts (Master or Dwindle) on the fly

notif="$HOME/.config/swaync/images/ja.png"

LAYOUT=$(hyprctl -j getoption general:layout | jq '.str' | sed 's/"//g')

case $LAYOUT in
"dwindle")
  hyprctl eval 'hl.config({ general = { layout = "master" } })'
  notify-send -e -u low -i "$notif" " Master Layout"
  ;;
"master")
  hyprctl eval 'hl.config({ general = { layout = "dwindle" } })'
  notify-send -e -u low -i "$notif" " Dwindle Layout"
  ;;
*)
  hyprctl eval 'hl.config({ general = { layout = "dwindle" } })'
  notify-send -e -u low -i "$notif" " Dwindle Layout"
  ;;
esac
