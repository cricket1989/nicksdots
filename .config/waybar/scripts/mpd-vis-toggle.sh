#!/usr/bin/env bash
# Toggle MPD status module visible/hidden.
# Pairs with custom/mpd-btn (signal 11).

STATE_DIR="${XDG_STATE_HOME:-$HOME/.local/state}/waybar"
STATE_FILE="$STATE_DIR/mpd-open"
mkdir -p "$STATE_DIR"

if [[ -f "$STATE_FILE" ]]; then
    rm "$STATE_FILE"
else
    touch "$STATE_FILE"
fi

pkill -RTMIN+11 waybar
