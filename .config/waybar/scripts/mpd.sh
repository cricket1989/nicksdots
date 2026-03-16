#!/usr/bin/env bash
# Waybar MPD module (JSON). Requires: mpc, jq

status="$(mpc status 2>/dev/null)"
if [[ -z "$status" ]]; then
  jq -cn --arg t "󰝛  MPD off" '{text:$t, class:"mpd-off", tooltip:"mpd not running"}'
  exit 0
fi

track="$(mpc -f "%artist% - %title%" current 2>/dev/null)"
maxlen=25

if [ ${#track} -gt $maxlen ]; then
  track="${track:0:$maxlen}…"
fi

state_line="$(echo "$status" | sed -n '2p')"

state="$(echo "$state_line" | awk '{gsub(/[][]/,"",$1); print $1}')"
timepart="$(echo "$state_line" | awk '{print $3}')"     # 0:42/3:12
elapsed="${timepart%/*}"
total="${timepart#*/}"

percent="$(echo "$state_line" | sed -n 's/.*(\([0-9]\{1,3\}\)%).*/\1/p')"
[[ -z "$percent" ]] && percent=0

w=16
filled=$(( percent * w / 100 ))
empty=$(( w - filled ))
bar="$(printf '%0.s━' $(seq 1 $filled))$(printf '%0.s─' $(seq 1 $empty))"

icon=""
[[ "$state" == "paused" ]] && icon="󱢮"
[[ "$state" == "playing" ]] && icon="󰐔"
[[ "$state" == "stopped" ]] && icon=""

text="${icon}  ${track}\n${elapsed}/${total}  ${bar}"

jq -cn \
  --arg text "$text" \
  --arg class "mpd-$state" \
  --arg tooltip "$(printf "%s\n%s" "$track" "$status")" \
  '{text:$text, class:$class, tooltip:$tooltip}'
