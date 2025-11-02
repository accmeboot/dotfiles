#!/usr/bin/env bash

mkdir -p "$HOME/Screenshots"
filename="$HOME/Screenshots/$(date +'%Y-%m-%d-%H%M%S_screenshot.png')"
grim "$filename" && wl-copy < "$filename" && notify-send 'Screenshot' "Full screen captured\nSaved to: $filename\nCopied to clipboard" -i "$filename"