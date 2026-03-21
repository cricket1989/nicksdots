#!/usr/bin/env bash
# AMD GPU stats for Waybar — custom/gpu module
# Adapted from Pipshag/dotfiles_nord
#
# NOTE: Adjust hwmon paths for your system.
# Run: ls /sys/class/hwmon/hwmon*/name to find your GPU hwmon.
# Common AMD paths: hwmon4, hwmon5 — check which one reports 'amdgpu'.
#
# Usage in config.jsonc:
#   "custom/gpu": {
#     "exec": "~/.config/waybar-clean/scripts/gpu-amd.sh",
#     "return-type": "json",
#     "format": "  {}",
#     "interval": 2,
#     "tooltip": "{tooltip}"
#   }

# Auto-detect AMD GPU hwmon
HWMON=""
for d in /sys/class/hwmon/hwmon*; do
    if [[ -f "$d/name" ]] && grep -q "amdgpu" "$d/name" 2>/dev/null; then
        HWMON="$d"
        break
    fi
done

if [[ -z "$HWMON" ]]; then
    echo '{"text": "GPU N/A", "tooltip": "AMD hwmon not found"}'
    exit 0
fi

# GPU clock (MHz → GHz)
raw_clock=""
if [[ -f "$HWMON/freq1_input" ]]; then
    raw_clock=$(cat "$HWMON/freq1_input" 2>/dev/null)
    clock=$(echo "scale=2; $raw_clock / 1000000000" | bc 2>/dev/null || echo "?")
    clock="${clock}GHz"
elif [[ -f /sys/class/drm/card1/device/pp_dpm_sclk ]]; then
    clock=$(grep '\*' /sys/class/drm/card1/device/pp_dpm_sclk 2>/dev/null | grep -o '[0-9]*Mhz' | head -1 || echo "?")
else
    clock="?GHz"
fi

# GPU temperature
temp_raw=$(cat "$HWMON/temp1_input" 2>/dev/null || echo "0")
temp=$(( temp_raw / 1000 ))

# GPU busy %
busy=$(cat "$HWMON/device/gpu_busy_percent" 2>/dev/null \
    || cat /sys/class/drm/card1/device/gpu_busy_percent 2>/dev/null \
    || echo "?")

echo "{\"text\": \"${clock} |   ${temp}°C <span color=\\\"darkgray\\\">| ${busy}%</span>\", \"tooltip\": \"GPU: ${temp}°C | Load: ${busy}% | Clock: ${clock}\", \"class\": \"custom-gpu\"}"
