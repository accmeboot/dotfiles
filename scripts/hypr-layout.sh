#!/bin/bash

l_group="󰖯"
l_norm="󰕴"
l_float="󰖲"

workspace=$(hyprctl activeworkspace | awk '/^workspace ID/ {print $3}')
readarray windows <<< "$(hyprctl clients | awk \
    '/^Window/ {address = $2} \
    /workspace:/ && $2 == "'$workspace'" { print address }')"

is_grouped(){
  hyprctl clients | awk \
    '/^Window '$1'/ { found_window = 1; next } \
    /^Window/ { found_window = 0 } \
    found_window && /grouped:/ {
      if ($2 != "0") {
        exit 0
      } else {
        exit 1
      }
    }'
}

is_float(){
  hyprctl clients | awk \
    '/^Window '$1'/ { found_window = 1; next } \
    /^Window/ { found_window = 0 } \
    found_window && /floating:/ {
      if ($2 != "0") {
        exit 0
      } else {
        exit 1
      }
    }'
}

for window in ${windows[@]}; do
  if is_float $window; then
    echo $l_float
    exit 0
  fi

  if is_grouped $window; then
    echo $l_group
    exit 0
  fi
done

echo $l_norm
