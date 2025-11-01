#!/usr/bin/env bash

IFS=':'

SCRIPT_DIR="$HOME/dotfiles/scripts"

get_selection() {
  for p in $PATH; do
    ls "$p" 2>/dev/null
  done | "$SCRIPT_DIR/launcher/show-launcher.sh"
}

if selection=$( get_selection ); then
  hyprctl dispatch exec "$selection" 
fi
