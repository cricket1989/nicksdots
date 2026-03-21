#!/usr/bin/env bash
# Waybar launcher — called from Hyprland or session startup
# To switch themes, use: ~/.config/waybar/switch-theme.sh <layout> [style]

killall -9 waybar 2>/dev/null
killall -9 swaync 2>/dev/null

swaync &

waybar &
