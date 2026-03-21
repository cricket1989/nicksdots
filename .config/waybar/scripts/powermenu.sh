#!/usr/bin/env bash
# ─────────────────────────────────────────────────────────────
#  Power Menu — Nord-themed rofi
# ─────────────────────────────────────────────────────────────

THEME="$HOME/.local/share/rofi/themes/nord-power/style.rasi"

# Toggle off if already open
if pgrep -x rofi &>/dev/null; then
    pkill -x rofi
    exit 0
fi

OPTIONS=" Lock\n⏾ Suspend\n↺ Reboot\n⏻ Shutdown\n⇠ Logout"

CHOSEN=$(echo -e "$OPTIONS" | rofi \
    -dmenu \
    -i \
    -p "" \
    -theme "$THEME" \
    -no-custom \
    -selected-row 0)

case "$CHOSEN" in
    " Lock")
        loginctl lock-session
        ;;
    "⏾ Suspend")
        systemctl suspend
        ;;
    "↺ Reboot")
        systemctl reboot
        ;;
    "⏻ Shutdown")
        systemctl poweroff
        ;;
    "⇠ Logout")
        hyprctl dispatch exit 0
        ;;
esac
