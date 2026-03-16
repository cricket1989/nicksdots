#!/usr/bin/env bash
set -euo pipefail

# Where your wallpapers live (add more dirs if you want)
WALL_DIRS=(
  "$HOME/Pictures/walls/"
  "$HOME/Pictures/Wallpapers/"
  "$HOME/Pictures/Wall/"
)

# File types to include
EXTS="jpg jpeg png webp"

# Build file list
files="$(
  for d in "${WALL_DIRS[@]}"; do
    [[ -d "$d" ]] || continue
    # find images
    for e in $EXTS; do
      find "$d" -type f -iname "*.${e}" 2>/dev/null
    done
  done | sort -u
)"

IFS=$'\n'

# Show just the basename in rofi, but keep the full path via a delimiter
choice="$(
  echo "$files" \
  | awk -v FS="/" '{print $NF " :: " $0}' \
  | rofi -dmenu -i -p "Matugen (colors only)" -theme "$HOME/.local/share/rofi/themes/wallpapers.rasi"
  

)"

[[ -n "${choice}" ]] || exit 0

img_path="${choice#* :: }"
[[ -f "${img_path}" ]] || exit 0

# Generate + apply templates using your matugen config.toml
# (Matugen supports custom config path via -c) :contentReference[oaicite:0]{index=0}
matugen image -c "$HOME/.config/matugen/config.toml" "$img_path"

