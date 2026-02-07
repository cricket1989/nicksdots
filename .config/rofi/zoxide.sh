#!/usr/bin/env bash
chosen=$(zoxide query -l | rofi -show -dmenu -i -p "Jump to")
[ -n "$chosen" ] && kitty --working-directory "$chosen"
