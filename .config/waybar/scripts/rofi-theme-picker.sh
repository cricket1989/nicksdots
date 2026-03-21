#!/usr/bin/env bash
# ─────────────────────────────────────────────────────────
#  Waybar Theme Picker — Rofi frontend for switch-theme.sh
# ─────────────────────────────────────────────────────────

WAYBAR_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/waybar-clean"
LAYOUTS_DIR="$WAYBAR_DIR/layouts"
SWITCH_SCRIPT="$WAYBAR_DIR/switch-theme.sh"
THEME="$HOME/.local/share/rofi/themes/nord-switcher/style.rasi"
STATE_FILE="$WAYBAR_DIR/.current-theme"

# Build display list and key list in parallel arrays
declare -a display_items
declare -a exec_args

for layout_dir in "$LAYOUTS_DIR"/*/; do
    layout=$(basename "$layout_dir")

    if [[ -d "$layout_dir/styles" ]]; then
        for style_file in "$layout_dir/styles/"*.css; do
            [[ -f "$style_file" ]] || continue
            style=$(basename "$style_file" .css)
            display_items+=("  $layout  /  $style")
            exec_args+=("$layout $style")
        done
    else
        display_items+=("  $layout")
        exec_args+=("$layout")
    fi
done

# Mark active theme
current=""
[[ -f "$STATE_FILE" ]] && current=$(cat "$STATE_FILE")

# Build display with active marker
declare -a labeled
for i in "${!display_items[@]}"; do
    key="${exec_args[$i]}"
    if [[ "$key" == "$current" ]]; then
        labeled+=("● ${display_items[$i]}")
    else
        labeled+=("  ${display_items[$i]}")
    fi
done

# Show rofi picker
selected=$(printf '%s\n' "${labeled[@]}" | rofi \
    -dmenu \
    -i \
    -p "Waybar" \
    -theme "$THEME" \
    -no-custom)

[[ -z "$selected" ]] && exit 0

# Strip leading markers/spaces to match back to exec_args
clean=$(echo "$selected" | sed 's/^[● ]*//;s/  */ /g;s/^ //;s/ $//')

# Find and execute matching theme
for i in "${!display_items[@]}"; do
    # Normalize display item for comparison
    norm=$(echo "${display_items[$i]}" | sed 's/^[● ]*//;s/  */ /g;s/^ //;s/ $//')
    norm_sel=$(echo "$clean" | sed 's/^[● ]*//;s/  */ /g;s/^ //;s/ $//')
    if [[ "$norm" == "$norm_sel" ]]; then
        read -ra parts <<< "${exec_args[$i]}"
        bash "$SWITCH_SCRIPT" "${parts[@]}"
        exit 0
    fi
done

# Fallback: try to match directly
read -ra parts <<< "$clean"
bash "$SWITCH_SCRIPT" "${parts[@]}"
