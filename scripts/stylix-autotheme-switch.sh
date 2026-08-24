#!/usr/bin/env bash

LIGHT_HOUR=8
DARK_HOUR=19

while true; do
  CURRENT_HOUR=$(date +'%H')

  if [ $CURRENT_HOUR -ge $LIGHT_HOUR ] && [ $CURRENT_HOUR -lt $DARK_HOUR ]; then
    set-light-theme
  else
    set-dark-theme
  fi

  sleep 3600
done
