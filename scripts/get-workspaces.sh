#!/bin/sh
swaymsg -t get_workspaces | jq -c '[.[] | {name: .name, focused: .focused, urgent: .urgent}]'

swaymsg -t subscribe -m '[ "workspace" ]' | while read event; do
  swaymsg -t get_workspaces | jq -c '[.[] | {name: .name, focused: .focused, urgent: .urgent}]'
done

