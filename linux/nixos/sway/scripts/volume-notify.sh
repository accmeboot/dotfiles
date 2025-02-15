#!/bin/bash

# Get the current volume
VOLUME=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{print int($2 * 100)}')

# Send the notification
notify-send -a volume -h int:value:"$VOLUME" -h string:x-canonical-private-synchronous:volume "󰽟     ${VOLUME}%"
