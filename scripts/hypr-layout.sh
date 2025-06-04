#!/bin/bash

l_group="󰖯"
l_norm="󰕴"
l_float="󰖲"

is_state(){
  hyprctl activewindow | awk '/'$1':/ {if ($2 != 0) { exit 0 } else { exit 1 }}'
}

if is_state floating; then
  echo $l_float
  exit 0
fi

if is_state grouped; then
  echo $l_group
  exit 0
fi

echo $l_norm
