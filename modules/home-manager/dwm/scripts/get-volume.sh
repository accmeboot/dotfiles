#!/bin/sh

volume=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{print int($2 * 100)}')

muted=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | grep -o "MUTED")

if [ -n "$muted" ]; then
    echo "0"
else
    echo "${volume}"
fi
