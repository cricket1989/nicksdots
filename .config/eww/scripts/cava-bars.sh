#!/usr/bin/env bash
# Streams CAVA ascii output as a single line for Eww to display.
# Requires: cava
# Uses unicode blocks for a more "dashboard" vibe.

# Map cava ascii (0-8) into blocks
blocks=( " " "▁" "▂" "▃" "▄" "▅" "▆" "▇" "█" )

cava | while read -r line; do
  # cava in ascii mode outputs a bunch of digits/spaces. We'll convert digits to blocks.
  out=""
  for (( i=0; i<${#line}; i++ )); do
    ch="${line:$i:1}"
    if [[ "$ch" =~ [0-8] ]]; then
      out+="${blocks[$ch]}"
    else
      # treat anything else (space) as gap
      out+=" "
    fi
  done
  echo "$out"
done
