#!/usr/bin/env bash
# CPU usage for sysinfo panel. Outputs empty when panel is closed.

STATE_FILE="${XDG_STATE_HOME:-$HOME/.local/state}/waybar/sysinfo-open"
[[ -f "$STATE_FILE" ]] || { printf '{"text":"","tooltip":"","class":"hidden"}'; exit 0; }

# Read /proc/stat twice with 0.5s gap for accurate idle delta
read_stat() { awk '/^cpu /{print $2,$3,$4,$5,$6,$7,$8}' /proc/stat; }
s1=$(read_stat); sleep 0.5; s2=$(read_stat)

usage=$(awk -v s1="$s1" -v s2="$s2" 'BEGIN{
    split(s1,a," "); split(s2,b," ")
    idle1=a[4]+a[5]; total1=a[1]+a[2]+a[3]+a[4]+a[5]+a[6]+a[7]+a[8]
    idle2=b[4]+b[5]; total2=b[1]+b[2]+b[3]+b[4]+b[5]+b[6]+b[7]+b[8]
    dt=total2-total1; di=idle2-idle1
    printf "%.0f", (dt-di)/dt*100
}')

printf '{"text":"󰐟 %s%%","tooltip":"CPU: %s%%"}' "$usage" "$usage"
