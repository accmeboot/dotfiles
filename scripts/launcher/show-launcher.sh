#!/usr/bin/env bash

SCRIPT_DIR="$HOME/dotfiles/scripts"

sort -u \
  | grep -v '^[[]$' \
  | fzf --print-query \
        --color=16 \
        --no-scrollbar \
        --gutter=' ' \
        --layout=reverse \
  | tail -1
