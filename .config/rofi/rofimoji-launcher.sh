#!/usr/bin/env bash

## Rofimoji themed launcher wrapper

dir="$HOME/.config/rofi/launchers/type-1"
theme='style-7'

rofimoji \
  -modi "unicode" \
  -show unicode \
  -theme "${dir}/${theme}.rasi"

