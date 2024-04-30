#!/bin/bash

monitors_state_dir=$HOME/.local/state/hyprmonitors
monitors_state_file=$monitors_state_dir/rc.log

internal_monitor=$(grep "^eDP-" "$monitors_state_file")
external_monitor=$(grep "^DP-" "$monitors_state_file")

# Check if the file exists and is readable
if [ ! -f "$monitors_state_file" ] || [ ! -r "$monitors_state_file" ]; then
  echo "Error: Cannot read $monitors_state_file" >&2
  exit 1
fi

if grep open /proc/acpi/button/lid/LID0/state; then
  hyprctl keyword monitor "$internal_monitor"
else

  if [ -n "$external_monitor" ]; then
    internal_monitor_name=$(echo $internal_monitor | cut -d, -f1)
    hyprctl keyword monitor "$internal_monitor_name, disable"
  else
    systemctl suspend
  fi

fi
