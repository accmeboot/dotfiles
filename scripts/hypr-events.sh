#!/bin/bash

SIGNAL=$1  # Configure this in waybar config

handle_event() {
    local event="$1"
    case "$event" in
        activewindow*|workspace*|focusedmon*|changefloatingmode*|togglegroup*)
            # Send signal to waybar to update your custom module
            pkill -RTMIN+$SIGNAL waybar
            ;;
    esac
}

# Listen to Hyprland events
socat -U - UNIX-CONNECT:$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock | while read -r line; do
    handle_event "$line"
done
