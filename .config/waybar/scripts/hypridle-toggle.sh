#!/usr/bin/env bash
set -e

if systemctl --user is-active --quiet hypridle.service; then
  systemctl --user stop hypridle.service
else
  systemctl --user start hypridle.service
fi

# optional: ping waybar to refresh immediately (if you use signals)
# pkill -RTMIN+8 waybar 2>/dev/null || true
