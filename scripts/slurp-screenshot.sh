#!/bin/sh

filename="$HOME/Screenshots/$(date +'%Y-%m-%d-%H%M%S_screenshot.png')"
mkdir -p "$HOME/Screenshots"
grim -g "$(slurp)" "$filename" && wl-copy < "$filename" && notify-send 'Screenshot' "Area selection captured\nSaved to: $filename\nCopied to clipboard" -i "$filename"
