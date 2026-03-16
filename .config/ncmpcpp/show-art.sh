#!/usr/bin/env bash
set -euo pipefail

ART="$HOME/.config/ncmpcpp/art/wallhaven-x6wpdo.jpg"

read -r rows cols < <(stty size)
W="$cols"
H="$rows"

clear

# --align center works on your kitty; no --valign on 0.45
kitty +kitten icat \
  --transfer-mode=memory \
  --scale-up \
  --align center \
  --place "${W}x${H}@0x0" \
  "$ART"

tail -f /dev/null
