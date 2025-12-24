#!/usr/bin/env bash

# volume.sh
# Usage: volume.sh up|down|mute

STEP=2%
SINK="@DEFAULT_AUDIO_SINK@"

case "$1" in
    up)
        wpctl set-volume -l 1 "$SINK" "$STEP"+
        ;;
    down)
        wpctl set-volume "$SINK" "$STEP"-
        ;;
    mute)
        wpctl set-mute "$SINK" toggle
        ;;
    *)
        echo "Usage: $0 {up|down|mute}"
        exit 1
        ;;
esac

VOL_INFO=$(wpctl get-volume "$SINK")   # e.g., "Volume: 0.78 [MUTED]" or "Volume: 0.86"
VOL=$(echo "$VOL_INFO" | awk '{print $2}')  # extract the float

# Check for [MUTED]
if echo "$VOL_INFO" | grep -q "\[MUTED\]"; then
    dunstify -h string:x-dunst-stack-tag:audio "Volume" "Muted" -r 2593
else
    # Convert float to integer percentage
    VOL_PERC=$(awk "BEGIN {printf \"%d\", ($VOL*100+0.5)}")
    dunstify -h string:x-dunst-stack-tag:audio "Volume" -h int:value:"$VOL_PERC" -r 2593
fi
