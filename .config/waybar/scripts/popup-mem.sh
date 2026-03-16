#!/usr/bin/env bash
set -euo pipefail

CHOICE="$(
  (echo "btop (Memory view)"
   echo "free -h"
   echo "ps: top memory processes") \
  | rofi -dmenu -i -p "Memory" -theme-str 'window {width: 520px;}'
)"

case "${CHOICE:-}" in
  "btop (Memory view)") kitty -e btop ;;
  "free -h") kitty -e bash -lc 'free -h; echo; read -n 1 -s -r -p "press any key..."' ;;
  "ps: top memory processes") kitty -e bash -lc 'ps aux --sort=-%mem | head -n 25 | less -R' ;;
esac
