#!/usr/bin/env bash

IFS=':'

SCRIPT_DIR="$HOME/dotfiles/scripts"

stats=$("$SCRIPT_DIR/system-monitor.sh" 2>&1)

get_selection() {
  for p in $PATH; do
    ls "$p" 2>/dev/null
  done | sort -u | grep -v '^[[]$' | fzf --print-query --color=16 --no-scrollbar --gutter=' ' --highlight-line --footer "$stats" | tail -1
}

if selection=$( get_selection ); then
  exec systemd-run --user -- sh -c "$selection"
fi
