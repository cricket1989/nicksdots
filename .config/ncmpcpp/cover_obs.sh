#!/usr/bin/env bash
set -euo pipefail

# Set this to your actual MPD music directory (must match MPD's music_directory).
 MUSIC_DIR="$HOME/Music/MPD"


COVER="/tmp/album_cover.png"
EMB="/tmp/embedded_cover.jpg"
SIZE="700"

# Current track file path as stored in MPD (relative to MUSIC_DIR)
rel="$(mpc --format %file% current)"
if [[ -z "${rel:-}" ]]; then
  exit 0
fi

file="$MUSIC_DIR/$rel"
album_dir="$(dirname "$file")"

# 1) Try embedded cover (best when present)
# (If this fails, we'll fall back to folder images)
rm -f "$EMB" 2>/dev/null || true
ffmpeg -loglevel error -y -i "$file" "$EMB" 2>/dev/null || true

if [[ -s "$EMB" ]]; then
  art="$EMB"
else
  # 2) Try common folder cover names
  art="$(find "$album_dir" -maxdepth 1 -type f \
    \( -iname 'cover.*' -o -iname 'folder.*' -o -iname 'front.*' -o -iname 'album.*' \) \
    \( -iname '*.jpg' -o -iname '*.jpeg' -o -iname '*.png' \) \
    | head -n 1 || true)"
fi

# 3) Fallback cover
if [[ -z "${art:-}" ]]; then
  art="$HOME/.config/ncmpcpp/default_cover.png"
fi

# Render to a predictable png for the display pane
ffmpeg -loglevel error -y -i "$art" -vf "scale=$SIZE:-1" "$COVER"
