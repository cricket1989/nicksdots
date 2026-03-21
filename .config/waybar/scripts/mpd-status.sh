#!/usr/bin/env bash
set -euo pipefail

STATE_FILE="${XDG_STATE_HOME:-$HOME/.local/state}/waybar/mpd-open"

if [[ ! -f "$STATE_FILE" ]]; then
  echo '{"text":"","class":"hidden"}'
  exit 0
fi

if systemctl --user is-active --quiet mpd.service; then
  # If mpc exists, show play/pause state
  if command -v mpc >/dev/null 2>&1; then
    state="$(mpc status 2>/dev/null | sed -n '2p' || true)"
    if echo "$state" | grep -q '\[playing\]'; then
      echo '{"text":"󰎆","tooltip":"ON","class":"on"}'
    else
      echo '{"text":"󰎆","tooltip":"ON","class":"on"}'
    fi
  else
    echo '{"text":"󰎆","tooltip":"ON","class":"on"}'
  fi
else
  echo '{"text":"󰎇","tooltip":"OFF","class":"off"}'
fi
