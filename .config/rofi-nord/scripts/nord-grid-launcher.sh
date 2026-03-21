#!/usr/bin/env bash
# Nord Grid App Launcher
# Triggered by waybar custom/os_button or custom/launcher

rofi \
    -show drun \
    -theme "$HOME/.local/share/rofi/themes/nord-grid/style.rasi" \
    -icon-theme "Papirus-Nord" \
    -show-icons \
    -terminal kitty \
    -kb-cancel Escape \
    -drun-display-format "{name}" \
    -no-drun-match-fields "generic,categories,comment,exec" \
    -drun-match-fields "name"
