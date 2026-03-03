#!/bin/bash

VIDEO=$(find . -maxdepth 2 -type f \( -iname "*.mkv" -o -iname "*.mp4" -o -iname "*.avi" -o -iname "*.mov" \) | sort -V | fzf --tiebreak=index --prompt="Select Video > ")

[ -z "$VIDEO" ] && exit

AUDIO=$(find . -maxdepth 2 -type f \( -iname "*.mka" -o -iname "*.mp3" -o -iname "*.aac" -o -iname "*.wav" -o -iname "*.m4a" -o -iname "*.mkv" \) | sort -V | fzf --tiebreak=index --prompt="Select Audio (ESC to skip) > ")

if [ -n "$AUDIO" ]; then
    echo "Playing: $VIDEO"
    echo "With Audio: $AUDIO"
    mpv "$VIDEO" --audio-file="$AUDIO"
else
    echo "Playing: $VIDEO (no external audio)"
    mpv "$VIDEO"
fi
