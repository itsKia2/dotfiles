#!/usr/bin/env bash

STEP=1%   # adjust brightness by 5%
DEVICE="backlight"   # or your specific backlight device

case "$1" in
    up)
        brightnessctl -e4 -n2 set +$STEP
        ;;
    down)
        brightnessctl -e4 -n2 set $STEP-
        ;;
    *)
        echo "Usage: $0 {up|down}"
        exit 1
        ;;
esac

# Get current brightness percentage
# brightnessctl outputs like: 1500/3000 (50%)
BRIGHTNESS=$(brightnessctl get)
MAX=$(brightnessctl max)
PERC=$((BRIGHTNESS * 100 / MAX))

# Send notification
dunstify -h string:x-dunst-stack-tag:brightness "Brightness" -h int:value:"$PERC" -r 2594
