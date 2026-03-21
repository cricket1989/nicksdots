#!/usr/bin/env bash
# ─────────────────────────────────────────────────────────────
#  wlogout-power.sh
#  Reads the active waybar theme from .current-theme,
#  symlinks the matching color palette, then launches wlogout.
# ─────────────────────────────────────────────────────────────

WLOGOUT_DIR="$HOME/.config/wlogout"
COLORS_DIR="$WLOGOUT_DIR/colors/waybar"
ACTIVE_LINK="$COLORS_DIR/active.css"
STATE="$HOME/.config/waybar-clean/.current-theme"

# ── Read active theme ───────────────────────────────────────
theme_str=""
[[ -f "$STATE" ]] && theme_str=$(cat "$STATE")
theme_str="${theme_str,,}"   # lowercase

# ── Map theme string → color file ──────────────────────────
pick_colors() {
  local t="$1"
  case "$t" in
    *tokyo-moon*)                echo "$COLORS_DIR/tokyo-moon.css" ;;
    *tokyo-night*)               echo "$COLORS_DIR/tokyo-night.css" ;;
    *nord*|*pipshag*)            echo "$COLORS_DIR/nord.css" ;;
    *gruvbox*)                   echo "$COLORS_DIR/gruvbox.css" ;;
    *everforest*)                echo "$COLORS_DIR/everforest.css" ;;
    *miasma*)                    echo "$COLORS_DIR/miasma.css" ;;
    *nightfox*)                  echo "$COLORS_DIR/nightfox.css" ;;
    *kanagawa*)                  echo "$COLORS_DIR/kanagawa.css" ;;
    *cjbassi*solarized*|*cjbassi) echo "$COLORS_DIR/solarized.css" ;;
    *matugen*)                   echo "$COLORS_DIR/matugen.css" ;;
    *)                           echo "$COLORS_DIR/matugen.css" ;;
  esac
}

color_file=$(pick_colors "$theme_str")

# Fall back to matugen if the specific file doesn't exist
[[ -f "$color_file" ]] || color_file="$COLORS_DIR/matugen.css"

# ── Symlink active colors ───────────────────────────────────
ln -sf "$color_file" "$ACTIVE_LINK"

# ── Launch wlogout ──────────────────────────────────────────
exec wlogout \
  --protocol layer-shell \
  --css "$WLOGOUT_DIR/wlogout-waybar.css" \
  --layout "$WLOGOUT_DIR/layout" \
  --buttons-per-row 3
