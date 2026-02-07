#!/usr/bin/env zsh
set -euo pipefail

MON="DP-2"

# Rotate DP-2 to portrait (90° clockwise).
# Hyprland "transform" values:
# 0 = normal, 1 = 90°, 2 = 180°, 3 = 270°

hyprctl keyword monitor "DP-2,transform,1"

# Small delay helps some setups (Waybar + layer surfaces) settle
sleep 0.2

# Restart Waybar so it re-detects monitor layout/orientation
pkill -x waybar 2>/dev/null || true
sleep 0.1
nohup waybar >/dev/null 2>&1 &
disown
