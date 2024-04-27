#!/usr/bin/env zsh

if grep open /proc/acpi/button/lid/LID0/state; then
  hyprctl keyword monitor "eDP-2, 1920x1200@165,0x0,1"
else

  if hyprctl monitors | grep -c "Monitor DP-1"; then
    hyprctl keyword monitor "eDP-2, disable"
  else
    systemctl suspend
  fi
fi
