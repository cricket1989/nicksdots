#!/usr/bin/env bash
# CPU temperature for sysinfo panel. Outputs empty when panel is closed.

STATE_FILE="${XDG_STATE_HOME:-$HOME/.local/state}/waybar/sysinfo-open"
[[ -f "$STATE_FILE" ]] || { printf '{"text":"","tooltip":"","class":"hidden"}'; exit 0; }

# Find the CPU/k10temp/coretemp hwmon
temp=""
for dir in /sys/class/hwmon/hwmon*; do
    name=$(cat "$dir/name" 2>/dev/null)
    if [[ "$name" == "k10temp" || "$name" == "coretemp" || "$name" == "zenpower" ]]; then
        raw=$(cat "$dir/temp1_input" 2>/dev/null)
        temp=$(( raw / 1000 ))
        break
    fi
done

[[ -z "$temp" ]] && { printf '{"text":"","tooltip":""}'; exit 0; }

icon="󰔏"
class="normal"
(( temp >= 80 )) && { icon="󱃂"; class="critical"; }
(( temp >= 65 && temp < 80 )) && { icon="󰔏"; class="warning"; }

printf '{"text":"%s %s°C","tooltip":"CPU Temp: %s°C","class":"%s"}' \
    "$icon" "$temp" "$temp" "$class"
