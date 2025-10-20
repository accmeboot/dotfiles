#!/usr/bin/env bash

IFS=':'

get_selection() {
  for p in $PATH; do
    ls "$p"
  done | sort -u | fzf --print-query --color=16 --no-scrollbar --gutter=' ' | tail -1
}

if selection=$( get_selection ); then
  exec systemd-run --user -- sh -c "$selection"
fi
