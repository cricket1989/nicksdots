#!/usr/bin/env bash
# Waybar custom MPD module (JSON). Requires: mpc, jq

status="$(mpc status 2>/dev/null)"
if [[ -z "$status" ]]; then
  jq -cn --arg t "MPD off" '{text:$t, class:"mpd-off", tooltip:"mpd not running"}'
  exit 0
fi

line1="$(mpc -f "%artist% - %title%" current 2>/dev/null)"
state_line="$(echo "$status" | sed -n '2p')"

# state: [playing] or [paused]
state="$(echo "$state_line" | awk '{gsub(/[][]/,"",$1); print $1}')"
timepart="$(echo "$state_line" | awk '{print $3}')"     # e.g. 0:42/3:12
elapsed="${timepart%/*}"
total="${timepart#*/}"

# percent: 0-100
percent="$(echo "$state_line" | sed -n 's/.*(\([0-9]\{1,3\}\)%).*/\1/p')"
[[ -z "$percent" ]] && percent=0

# make a bar
w=16
filled=$(( percent * w / 100 ))
empty=$(( w - filled ))
bar="$(printf '%0.s━' $(seq 1 $filled))$(printf '%0.s─' $(seq 1 $empty))"

icon=""
[[ "$state" == "paused" ]] && icon=""
[[ "$state" == "playing" ]] && icon=""

text="${icon}  ${line1}\n${elapsed}/${total}  ${bar}"

jq -cn \
  --arg text "$text" \
  --arg class "mpd-$state" \
  --arg tooltip "$(printf "%s\n%s" "$line1" "$status")" \
  '{text:$text, class:$class, tooltip:$tooltip}'
