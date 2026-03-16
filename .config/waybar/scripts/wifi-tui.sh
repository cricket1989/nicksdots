#!/usr/bin/env bash
# Waybar custom WiFi module via NetworkManager (nmcli)
# Outputs JSON: {"text":"󰤨","tooltip":"SSID • 78%"}

set -euo pipefail

# If NM isn't running, just show "down"
if ! command -v nmcli >/dev/null 2>&1; then
  echo '{"text":"󰤭","tooltip":"nmcli not found"}'
  exit 0
fi

wifi_state="$(nmcli -t -f WIFI g 2>/dev/null | head -n1 || true)"
if [[ "$wifi_state" != "enabled" ]]; then
  echo '{"text":"󰤭","tooltip":"WiFi disabled"}'
  exit 0
fi

# Active WiFi (yes:<SSID>:<signal>)
line="$(nmcli -t -f ACTIVE,SSID,SIGNAL dev wifi | awk -F: '$1=="yes"{print $0; exit}')"

if [[ -z "${line:-}" ]]; then
  echo '{"text":"󰤯","tooltip":"Not connected"}'
  exit 0
fi

ssid="$(echo "$line" | cut -d: -f2)"
signal="$(echo "$line" | cut -d: -f3)"
signal="${signal:-0}"

# icon by signal
icon="󰤯"
if   (( signal >= 80 )); then icon="󰤨"
elif (( signal >= 60 )); then icon="󰤥"
elif (( signal >= 40 )); then icon="󰤢"
elif (( signal >= 20 )); then icon="󰤟"
else icon="󰤯"
fi

# JSON for waybar
printf '{"text":" %s ","tooltip":"%s • %s%%"}\n' "$icon" "${ssid//\"/\\\"}" "$signal"
