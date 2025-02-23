#!/bin/bash
# Get audio device
AUDIO_DEVICE=$(wpctl status | grep "\*" | head -1 | awk '{for(i=4; i<=NF; i++) printf "%s ", $i; print ""}')

# Get formatted audio device
FORMATTED_AUDIO_DEVICE=$(echo $AUDIO_DEVICE | awk '{print $1 " " $2 " " $3}')

echo "${FORMATTED_AUDIO_DEVICE}"
