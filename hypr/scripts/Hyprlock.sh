#!/usr/bin/env bash

# Called by hypridle for every session lock, including idle and manual locks.
hyprctl switchxkblayout all 0
pidof hyprlock >/dev/null && exit 0

hyprlock &
lock_pid=$!

(
    sleep 30
    if kill -0 "$lock_pid" 2>/dev/null; then
        hyprctl dispatch 'hl.dsp.dpms({ action = "disable" })'
    fi
) &
timer_pid=$!

wait "$lock_pid"
lock_status=$?
kill "$timer_pid" 2>/dev/null || true
wait "$timer_pid" 2>/dev/null || true
exit "$lock_status"
