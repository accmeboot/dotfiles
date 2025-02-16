#!/bin/bash

# Initial volume
wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{print $2 * 100}'

# Subscribe to changes using pw-mon
pw-mon | while read -r line; do
    if [[ $line == *"volume"* ]] || [[ $line == *"sink"* ]]; then
        wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{print $2 * 100}'
    fi
done
