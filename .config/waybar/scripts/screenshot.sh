#!/usr/bin/env bash
# ─────────────────────────────────────────────────────────────
#  Screenshot — grim + slurp
#  Usage: screenshot.sh [region|full|window]
#
#  All modes: save to ~/Pictures/Screenshots/ + copy to clipboard
# ─────────────────────────────────────────────────────────────

SAVE_DIR="$HOME/Pictures/Screenshots"
mkdir -p "$SAVE_DIR"

TIMESTAMP=$(date +%Y%m%d_%H%M%S)
FILE="$SAVE_DIR/screenshot_$TIMESTAMP.png"

MODE="${1:-region}"

notify() {
    notify-send -i camera-photo -t 2500 "Screenshot" "$1"
}

case "$MODE" in
    region)
        # Interactive region select — saves + copies to clipboard
        COORDS=$(slurp -d 2>/dev/null)
        [[ -z "$COORDS" ]] && exit 0   # user cancelled
        grim -g "$COORDS" "$FILE" && \
        wl-copy < "$FILE" && \
        notify "Region saved & copied"
        ;;

    full)
        # All monitors — saves + copies to clipboard
        grim "$FILE" && \
        wl-copy < "$FILE" && \
        notify "Fullscreen saved & copied"
        ;;

    window)
        # Active window only
        GEOM=$(hyprctl activewindow -j | python3 -c \
            "import sys,json; w=json.load(sys.stdin); \
             print('{},{} {}x{}'.format(w['at'][0],w['at'][1],w['size'][0],w['size'][1]))")
        [[ -z "$GEOM" ]] && exit 1
        grim -g "$GEOM" "$FILE" && \
        wl-copy < "$FILE" && \
        notify "Window saved & copied"
        ;;

    *)
        echo "Usage: screenshot.sh [region|full|window]"
        exit 1
        ;;
esac
