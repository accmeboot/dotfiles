#!/bin/bash

# Initial mute state
wpctl get-volume @DEFAULT_AUDIO_SINK@ | grep -q MUTED && echo "true" || echo "false"

# Subscribe to changes using pw-mon
pw-mon | while read -r line; do
    if [[ $line == *"mute"* ]] || [[ $line == *"sink"* ]]; then
        wpctl get-volume @DEFAULT_AUDIO_SINK@ | grep -q MUTED && echo "true" || echo "false"
    fi
done
