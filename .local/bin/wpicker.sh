#!/usr/bin/env bash
set -euo pipefail

# Where your wallpapers live (add more dirs if you want)
WALL_DIRS=(
  "$HOME/Pictures/Walls"
  "$HOME/Pictures/walls"
)

# File types to include
EXTS="jpg jpeg png webp"

# Thumbnail cache
CACHE_DIR="${XDG_CACHE_HOME:-$HOME/.cache}/rofi-wallthumbs"
mkdir -p "$CACHE_DIR"

# Small, clean "grid picker" style embedded directly in the command
# (Doesn't hardcode colors, so it plays nice with your existing rofi theme/colors)
THEME_STR='
configuration { show-icons: true; }
window { width: 70%; border-radius: 14px; }
mainbox { padding: 12px; }
listview { columns: 4; lines: 3; fixed-height: true; spacing: 10px; }
element { padding: 10px; border-radius: 12px; orientation: vertical; }
element-icon { size: 7.0em; border-radius: 12px; }
element-text { margin: 6px 0px 0px 0px; horizontal-align: 0.5; }
'

thumb_for() {
  local img="$1"
  local key thumb
  key="$(printf "%s" "$img" | sha1sum | awk '{print $1}')"
  thumb="${CACHE_DIR}/${key}.png"

  # build thumb if missing or older than source
  if [[ ! -f "$thumb" || "$thumb" -ot "$img" ]]; then
    if command -v magick >/dev/null 2>&1; then
      magick "$img" -auto-orient -thumbnail 256x256^ -gravity center -extent 256x256 "$thumb"
    elif command -v convert >/dev/null 2>&1; then
      convert "$img" -auto-orient -thumbnail 256x256^ -gravity center -extent 256x256 "$thumb"
    else
      # No ImageMagick available; return original as a fallback "icon"
      printf "%s" "$img"
      return 0
    fi
  fi

  printf "%s" "$thumb"
}

# Gather files
mapfile -t files < <(
  for d in "${WALL_DIRS[@]}"; do
    [[ -d "$d" ]] || continue
    for e in $EXTS; do
      find "$d" -type f -iname "*.${e}" 2>/dev/null
    done
  done | sort -u
)

[[ "${#files[@]}" -gt 0 ]] || exit 0

# Build rofi input with icons:
# "basename :: fullpath\0icon\x1f/thumb.png"
menu_input="$(
  for f in "${files[@]}"; do
    base="$(basename "$f")"
    icon="$(thumb_for "$f")"
    printf "%s :: %s\0icon\x1f%s\n" "$base" "$f" "$icon"
  done
)"

choice="$(
  printf "%b" "$menu_input" \
  | rofi -dmenu -i -show-icons -p "Matugen" -theme-str "$THEME_STR"
)"

[[ -n "${choice}" ]] || exit 0

img_path="${choice#* :: }"
[[ -f "${img_path}" ]] || exit 0

matugen image "$HOME/.config/matugen/config.toml" "$img_path"

