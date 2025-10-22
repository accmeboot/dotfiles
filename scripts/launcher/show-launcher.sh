#!/usr/bin/env bash

SCRIPT_DIR="$HOME/dotfiles/scripts"
stats=$("$SCRIPT_DIR/stats/get-stats.sh" 2>&1)

sort -u \
  | grep -v '^[[]$' \
  | fzf --print-query \
        --color=16 \
        --no-scrollbar \
        --gutter=' ' \
        --footer "$stats" \
  | tail -1
