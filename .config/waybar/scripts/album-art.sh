#!/bin/bash
# waybar album art fetcher
# Works with spotify, mpd, and any playerctl source.
# Outputs local file path for the waybar image module.

CACHE="/tmp/waybar-art.jpg"
HASH_FILE="/tmp/waybar-art.hash"

art_url=$(playerctl metadata mpris:artUrl 2>/dev/null | head -1)

[[ -z "$art_url" ]] && exit 1

# Local file:// (MPD with embedded art via playerctld/mpd-mpris)
if [[ "$art_url" == file://* ]]; then
    local_path="${art_url#file://}"
    [[ -f "$local_path" ]] && echo "$local_path"
    exit 0
fi

# Remote URL — only re-download when URL changes
new_hash=$(printf '%s' "$art_url" | md5sum | cut -d' ' -f1)
old_hash=$(cat "$HASH_FILE" 2>/dev/null)

if [[ "$new_hash" != "$old_hash" ]]; then
    curl -s --max-time 5 "$art_url" -o "$CACHE" 2>/dev/null \
        && printf '%s' "$new_hash" > "$HASH_FILE"
fi

[[ -f "$CACHE" ]] && echo "$CACHE"
