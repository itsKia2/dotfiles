#!/usr/bin/env bash

CACHE_DIR="$HOME/.cache/spotify-art"
mkdir -p "$CACHE_DIR"

playerctl metadata --player=spotify --follow --format '{{mpris:artUrl}}|{{artist}}|{{title}}' |
while IFS='|' read -r art artist title; do
    [ -z "$title" ] && continue

    img="$CACHE_DIR/cover.jpg"

    # Download album art if it's a URL
    if [[ "$art" == http* ]]; then
        curl -sL "$art" -o "$img"
        art="$img"
    fi

    notify-send \
        -a "Spotify" \
        -h string:x-dunst-stack-tag:spotify \
        -i "$art" \
        "Now Playing" \
        "$artist — $title"
done
