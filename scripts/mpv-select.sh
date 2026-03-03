#!/bin/bash

VIDEO=$(find . -maxdepth 2 -type f \( -iname "*.mkv" -o -iname "*.mp4" -o -iname "*.avi" -o -iname "*.mov" \) | sort -V | fzf --tiebreak=index --prompt="1. Select Video > ")

[ -z "$VIDEO" ] && exit

AUDIO=$(find . -maxdepth 2 -type f \( -iname "*.mka" -o -iname "*.mp3" -o -iname "*.aac" -o -iname "*.wav" -o -iname "*.m4a" -o -iname "*.mkv" \) | sort -V | fzf --tiebreak=index --prompt="2. Select Audio (ESC to skip) > ")

SUBS=$(find . -maxdepth 2 -type f \( -iname "*.srt" -o -iname "*.ass" -o -iname "*.vtt" -o -iname "*.sub" \) | sort -V | fzf --tiebreak=index --prompt="3. Select Subtitles (ESC to skip) > ")

ARGS=()

if [ -n "$AUDIO" ]; then
    ARGS+=("--audio-file=$AUDIO")
fi

if [ -n "$SUBS" ]; then
    ARGS+=("--sub-file=$SUBS")
fi

echo "Launching: $VIDEO"
mpv "$VIDEO" "${ARGS[@]}"
