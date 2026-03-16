#!/usr/bin/env bash
set -euo pipefail

if systemctl --user is-active --quiet mpd.service; then
  # If mpc exists, show play/pause state
  if command -v mpc >/dev/null 2>&1; then
    state="$(mpc status 2>/dev/null | sed -n '2p' || true)"
    if echo "$state" | grep -q '\[playing\]'; then
      echo '{"text":"󰎆","tooltip":"MPD: running (playing)","class":"on"}'
    else
      echo '{"text":"󰎆","tooltip":"MPD: running","class":"on"}'
    fi
  else
    echo '{"text":"󰎆","tooltip":"MPD: running","class":"on"}'
  fi
else
  echo '{"text":"󰎇","tooltip":"MPD: stopped","class":"off"}'
fi
