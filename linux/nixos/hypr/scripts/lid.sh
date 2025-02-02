#!/bin/bash

if grep open /proc/acpi/button/lid/LID0/state; then
   hyprctl reload
else
  if [[ $(hyprctl monitors | grep "Monitor " | awk '{print $2}' | wc -l) -eq 1  ]]; then
    systemctl suspend && nohup hyprlock >& /dev/null &
  else

    internal_monitor=$(hyprctl monitors | grep "Monitor " | awk '{print $2}' | grep "eDP")

    if [[ $internal_monitor ]]; then
      hyprctl keyword monitor "$internal_monitor, disabled"  
    fi

  fi
fi
