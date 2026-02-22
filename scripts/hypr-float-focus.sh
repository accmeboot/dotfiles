#!/usr/bin/env bash

active_floating=$(hyprctl activewindow -j | jq -r '.floating')

if [ "$active_floating" = "true" ]; then
  hyprctl dispatch cyclenext tiled
else
  hyprctl dispatch cyclenext floating
fi
