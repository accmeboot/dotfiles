#!/bin/bash

ACTIVE_WORKSPACE=$(hyprctl activeworkspace | awk '/^workspace ID/ {print $3}')

get_windows(){
  hyprctl clients | awk \
    '/^Window/ {address = $2} \
    /workspace:/ && $2 == "'$ACTIVE_WORKSPACE'" { print address }'
}

is_window_grouped(){
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

has_grouped_window(){
  for window in "$@"; do
    if is_window_grouped "$window"; then
      return 0
    fi
  done

  return 1
}


toggle(){
  readarray -t WINDOWS <<< "$(get_windows)"

  # first we need to create a group by toggling it on the currently active window
  hyprctl dispatch togglegroup

  # second we exit if there is 1 window or the workspace already has a group
  if [ ${#WINDOWS[@]} -eq 1 ] || has_grouped_window "$WINDOWS"; then
    exit 0
  fi

  # third we loop over all windows
  # and move each one into the group we just created
  for window in ${WINDOWS[@]}; do
    if is_window_grouped $window; then
      continue
    fi

    hyprctl dispatch focuswindow address:0x${window}

    local directions=("l" "r" "u" "d")

    for direction in ${directions[@]}; do
      echo $direction
      if is_window_grouped $window; then
        break
      fi

      hyprctl dispatch moveintogroup ${direction}
    done
  done
}

toggle
