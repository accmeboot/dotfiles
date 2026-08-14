#!/usr/bin/env bash

while true; do
  NET="Offline  "
  if ip link | grep -q "state UP"; then
    NET="Online  "
  fi

  BAT=""
  if [ -d /sys/class/power_supply/BAT* ] 2>/dev/null; then
    CAPACITY=$(cat /sys/class/power_supply/BAT*/capacity 2>/dev/null | head -1)
    STATUS=$(cat /sys/class/power_supply/BAT*/status 2>/dev/null | head -1)
    
    if [ "$STATUS" = "Charging" ]; then
      BAT="Charging $CAPACITY%  "
    elif [ "$STATUS" = "Full" ]; then
      BAT="Full  "
    else
      BAT="Battery $CAPACITY%  "
    fi
  fi

  # Time
  TIME=$(date +'%H:%M')
  
  echo "$NET$BAT$TIME"
  sleep 1
done
