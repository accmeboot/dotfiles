#!/bin/bash
swaymsg -t get_inputs | awk -F'"' '/xkb_active_layout_name/ {print toupper(substr($4, 1, 2)); exit}'
