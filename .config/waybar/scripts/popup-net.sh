#!/usr/bin/env bash
set -euo pipefail

SSID="$(nmcli -t -f active,ssid dev wifi 2>/dev/null | sed -n 's/^yes://p' || true)"
IP="$(ip -4 route get 1.1.1.1 2>/dev/null | awk '/src/ {print $7; exit}' || true)"

CHOICE="$(
  (echo "Status: ${SSID:-wired}  ${IP:-no-ip}"
   echo "WiFi: connect"
   echo "WiFi: disconnect"
   echo "Edit connections"
   echo "Open nmtui"
   echo "Ping test") \
  | rofi -dmenu -i -p "Network" -theme-str 'window {width: 560px;}'
)"

case "${CHOICE:-}" in
  "WiFi: connect")
    nmcli -t -f ssid dev wifi | sed '/^$/d' \
      | rofi -dmenu -i -p "Connect to SSID" -theme-str 'window {width: 560px;}' \
      | xargs -r -I{} nmcli dev wifi connect "{}"
    ;;
  "WiFi: disconnect") nmcli dev disconnect wlan0 2>/dev/null || nmcli dev disconnect wifi 2>/dev/null || true ;;
  "Edit connections") kitty -e nmcli con show | less -R ;;
  "Open nmtui") kitty -e nmtui ;;
  "Ping test") kitty -e bash -lc 'ping -c 5 1.1.1.1; echo; read -n 1 -s -r -p "press any key..."' ;;
esac
