#!/usr/bin/env bash
set -u

COVER="/tmp/album_cover.png"

echo "[cover] pane started"
echo "[cover] waiting for $COVER"
echo ""

have() { command -v "$1" >/dev/null 2>&1; }

draw() {
  printf "\033c"   # reset screen (more reliable than clear)
  echo "[cover] $(date +%H:%M:%S)"
  if [[ -f "$COVER" ]]; then
    if have kitty; then
      kitty +kitten icat --clear --transfer-mode=file --place 40x20@0x0 "$COVER" 2>/dev/null || {
        echo "[cover] kitty icat failed"
      }
    else
      echo "[cover] kitty not found in PATH"
    fi
  else
    echo "No cover yet."
    echo "Waiting for $COVER"
  fi
}

draw

# Prefer inotify, else poll
if have inotifywait; then
  while inotifywait -q -q -e close_write "$COVER" 2>/dev/null; do
    draw
  done
else
  while true; do
    sleep 1
    draw
  done
fi

