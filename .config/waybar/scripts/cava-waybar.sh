#!/usr/bin/env bash
set -euo pipefail

# Chunky blocks from low -> high
RAMP=("▁" "▂" "▃" "▄" "▅" "▆" "▇" "█")

# LENGTH CONTROL:
# Increase/decrease this to change how "long" the bar is.
# ~18–28 usually feels like ~2 inches depending on font/DPI.
BARS=16

cava -p <(cat <<EOF
[general]
bars = ${BARS}
framerate = 60

[input]
method = pulse
source = auto

[output]
method = raw
raw_target = /dev/stdout
data_format = ascii
ascii_max_range = 6
EOF
) | while read -r line; do
  IFS=';' read -ra vals <<< "$line"

  out=""
  for v in "${vals[@]}"; do
    [[ "$v" =~ ^[0-9]+$ ]] || continue
    (( v < 0 )) && v=0
    (( v > 7 )) && v=7
    out+="${RAMP[$v]}"
  done

  printf '{"text":"%s","class":"cava"}\n' "$out"
done
