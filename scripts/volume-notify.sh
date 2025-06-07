#!/bin/bash

# Get the current volume
VOLUME=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{printf "%.0f", ($2 * 100)}')
ICON=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{if(match($0,/MUTED/)) { print " " } else {print " "}}')

# Send the notification
notify-send -a volume -h int:value:"$VOLUME" -h string:x-canonical-private-synchronous:volume "$ICON"
