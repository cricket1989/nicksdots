#!/usr/bin/env bash
SWAYBG_MODE="${SWAYBG_MODE:-fill}"


# remember last wallpaper (optional but useful)
STATE_FILE="${HOME}/.cache/current-wallpaper"
# ==========================================


WALLPAPER_DIR="$HOME/Pictures/Wallpapers"

die() { notify-send "Wallpaper" "Error: $*"; exit 1; }
info() { notify-send "Wallpaper" "$*"; }
require() { command -v "$1" >/dev/null 2>&1 || die "Missing: $1"; }




list_wallpapers() {
find "$WALLPAPER_DIR" -type f \
\( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.webp" \) \
| sort
}


pick_wallpaper() {
local -a files=("$@")
local menu=""


for f in "${files[@]}"; do
menu+="$(basename "$f")\0icon\x1f$f\n"
done


echo -en "$menu" | rofi -dmenu -i -p "Wallpaper" -show-icons -theme "$ROFI_THEME"
}


resolve_path() {
local selected="$1"; shift
for f in "$@"; do
[[ "$(basename "$f")" == "$selected" ]] && echo "$f" && return 0
done
return 1
}


apply_swww() {
require swww


if ! pgrep -x swww-daemon >/dev/null; then
swww-daemon >/dev/null 2>&1 &
disown || true
sleep 0.1
fi


swww img "$1" \
--transition-type wipe \
--transition-fps 144 \
--transition-step 255
}


apply_swaybg() {
require swaybg
pkill -x swaybg >/dev/null 2>&1 || true
swaybg -i "$1" -m "$SWAYBG_MODE" >/dev/null 2>&1 &
disown || true
}


run_matugen() {
require matugen
matugen image "$1" -m "$MATUGEN_MODE"
}


update_hyprlock() {
mkdir -p "$(dirname "$HYPRLOCK_LINK")"
ln -sf "$1" "$HYPRLOCK_LINK"
}


save_state() {
echo "$1" > "$STATE_FILE"
}


main() {
require rofi
[[ -d "$WALLPAPER_DIR" ]] || die "Directory not found: $WALLPAPER_DIR"


mapfile -t wallpapers < <(list_wallpapers)
[[ ${#wallpapers[@]} -gt 0 ]] || die "No wallpapers in $WALLPAPER_DIR"


selected="$(pick_wallpaper "${wallpapers[@]}")" || exit 0
[[ -n "$selected" ]] || exit 0


path="$(resolve_path "$selected" "${wallpapers[@]}")" || die "Invalid selection"


case "$WALLPAPER_BACKEND" in
swww) apply_swww "$path" ;;
swaybg) apply_swaybg "$path" ;;
*) die "Unknown backend: $WALLPAPER_BACKEND" ;;
esac


run_matugen "$path"
update_hyprlock "$path"
save_state "$path"


info "Wallpaper applied: $(basename "$path")"
}


main "$@"