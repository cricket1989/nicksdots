#!/usr/bin/env bash
# RAM usage for sysinfo panel. Outputs empty when panel is closed.

STATE_FILE="${XDG_STATE_HOME:-$HOME/.local/state}/waybar/sysinfo-open"
[[ -f "$STATE_FILE" ]] || { printf '{"text":"","tooltip":"","class":"hidden"}'; exit 0; }

awk '/MemTotal/{t=$2} /MemAvailable/{a=$2} END{
    used=(t-a)/1024/1024
    total=t/1024/1024
    pct=(t-a)/t*100
    printf "{\"text\":\"\\udb80\\ude98 %.1fG\",\"tooltip\":\"RAM: %.1fG / %.1fG (%.0f%%)\"}",
        used, used, total, pct
}' /proc/meminfo
