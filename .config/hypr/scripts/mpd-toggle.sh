#!/usr/bin/env bash
set -euo pipefail

# Toggle MPD user service (recommended)
if systemctl --user is-active --quiet mpd.service; then
  systemctl --user stop mpd.service
else
  systemctl --user start mpd.service
fi
