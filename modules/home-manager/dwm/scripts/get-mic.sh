#!/bin/sh

mic_volume=$(wpctl get-volume @DEFAULT_AUDIO_SOURCE@ | awk '{print int($2 * 100)}')

mic_muted=$(wpctl get-volume @DEFAULT_AUDIO_SOURCE@ | grep -o "MUTED")

if [ -n "$mic_muted" ]; then
    echo "0"
else
    echo "${mic_volume}"
fi
