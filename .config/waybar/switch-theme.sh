#!/usr/bin/env bash
# ─────────────────────────────────────────────────────────────
#  Waybar Theme Switcher
#  Usage:
#    ./switch-theme.sh <layout> [style]
#
#  Examples:
#    ./switch-theme.sh glass-gruv              # uses gruvbox (default)
#    ./switch-theme.sh glass-gruv kanagawa-ink # switches color variant
#    ./switch-theme.sh floating-islands
#    ./switch-theme.sh z-boyz
#
#  Layouts with multiple styles (in layouts/<name>/styles/):
#    glass-gruv: gruvbox, kanagawa-ink, tokyo-moon, city-mono, eva-blue, sevastopol, tmoon
#    floating-islands: default
#    arkboix: tokyo-night, everforest, gruvbox
#    pipshag-nord: nord, gruvbox
#
#  Layouts with a single style.css:
#    z-boyz, alchemy, subtle, ultra-minimal, waybar-v1, waybar-v2,
#    polybar, new, forest, kanagawa, kyoto, dracula, double-up, windows-xp,
#    cjbassi
# ─────────────────────────────────────────────────────────────

WAYBAR_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/waybar-clean"
LAYOUTS_DIR="$WAYBAR_DIR/layouts"
STATE_FILE="$WAYBAR_DIR/.current-theme"

list_themes() {
    echo "Available layouts:"
    for layout_dir in "$LAYOUTS_DIR"/*/; do
        layout=$(basename "$layout_dir")
        if [[ -d "$layout_dir/styles" ]]; then
            styles=$(ls "$layout_dir/styles/"*.css 2>/dev/null | xargs -I{} basename {} .css | tr '\n' ', ' | sed 's/,$//')
            echo "  $layout  [styles: $styles]"
        else
            echo "  $layout"
        fi
    done
}

# ── Args ─────────────────────────────────────────────────────
if [[ "$1" == "-l" || "$1" == "--list" ]]; then
    list_themes
    exit 0
fi

if [[ -z "$1" ]]; then
    echo "Usage: switch-theme.sh <layout> [style]"
    echo "       switch-theme.sh --list"
    exit 1
fi

LAYOUT="$1"
STYLE="${2:-}"
LAYOUT_DIR="$LAYOUTS_DIR/$LAYOUT"

if [[ ! -d "$LAYOUT_DIR" ]]; then
    echo "Error: layout '$LAYOUT' not found in $LAYOUTS_DIR"
    list_themes
    exit 1
fi

# ── Resolve config ────────────────────────────────────────────
CONFIG_FILE="$LAYOUT_DIR/config.jsonc"
if [[ ! -f "$CONFIG_FILE" ]]; then
    echo "Error: $CONFIG_FILE not found"
    exit 1
fi

# ── Resolve style ─────────────────────────────────────────────
if [[ -d "$LAYOUT_DIR/styles" ]]; then
    # Layout has multiple styles
    if [[ -z "$STYLE" ]]; then
        # Default to first style alphabetically, or 'default' if it exists
        if [[ -f "$LAYOUT_DIR/styles/default.css" ]]; then
            STYLE="default"
        elif [[ -f "$LAYOUT_DIR/styles/gruvbox.css" ]]; then
            STYLE="gruvbox"
        else
            STYLE=$(ls "$LAYOUT_DIR/styles/"*.css 2>/dev/null | head -1 | xargs basename | sed 's/\.css$//')
        fi
    fi
    STYLE_FILE="$LAYOUT_DIR/styles/$STYLE.css"
    if [[ ! -f "$STYLE_FILE" ]]; then
        echo "Error: style '$STYLE' not found for layout '$LAYOUT'"
        echo "Available styles: $(ls "$LAYOUT_DIR/styles/"*.css | xargs -I{} basename {} .css | tr '\n' ' ')"
        exit 1
    fi
else
    # Single style layout
    STYLE_FILE="$LAYOUT_DIR/style.css"
    if [[ ! -f "$STYLE_FILE" ]]; then
        echo "Error: $STYLE_FILE not found"
        exit 1
    fi
    STYLE="default"
fi

# ── Apply symlinks ────────────────────────────────────────────
ln -sf "$CONFIG_FILE" "$WAYBAR_DIR/config.jsonc"
ln -sf "$STYLE_FILE"  "$WAYBAR_DIR/style.css"

# ── Save state ────────────────────────────────────────────────
echo "$LAYOUT $STYLE" > "$STATE_FILE"

# ── Reload Waybar ─────────────────────────────────────────────
pkill waybar 2>/dev/null
sleep 0.2
waybar &
disown

echo "✓ Switched to: $LAYOUT${STYLE:+ / $STYLE}"
