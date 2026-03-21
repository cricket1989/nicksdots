#!/usr/bin/env bash
# Toggle sysinfo panel open/closed. Bind to right-click on pulseaudio
# or a dedicated custom/sysinfo-btn module.

STATE_DIR="${XDG_STATE_HOME:-$HOME/.local/state}/waybar"
STATE_FILE="$STATE_DIR/sysinfo-open"
mkdir -p "$STATE_DIR"

if [[ -f "$STATE_FILE" ]]; then
    rm "$STATE_FILE"
else
    touch "$STATE_FILE"
fi

# Signal all sysinfo custom modules to refresh (signal offset 10)
pkill -RTMIN+10 waybar
