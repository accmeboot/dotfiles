#!/bin/bash

result="$(dbus-send \
  --session \
  --print-reply \
  --dest=org.kde.StatusNotifierWatcher \
  /StatusNotifierWatcher \
  org.freedesktop.DBus.Properties.Get \
  string:"org.kde.StatusNotifierWatcher" \
  string:"RegisteredStatusNotifierItems" 2>/dev/null)"

app_list=$(echo "$result" | awk -F '"' '/string "/ {print $2}')

if [[ -z "$app_list" ]]; then
  echo "false"
else
  echo "true"
fi
