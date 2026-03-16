#!/usr/bin/env bash

## Unicode Launcher — themed rofi wrapper
## Uses rofi-unicode plugin mode

dir="$HOME/.config/rofi/launchers/type-1"
theme='style-7'

rofi \
    -modi "unicode" \
    -show unicode \
    -theme "${dir}/${theme}.rasi"
