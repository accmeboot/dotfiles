#!/bin/sh

if [ ! -f /sys/class/power_supply/BAT0/capacity ]; then
    exit 0
fi

battery_percent=$(cat /sys/class/power_supply/BAT0/capacity 2>/dev/null || echo "N/A")

echo "${battery_percent}"
