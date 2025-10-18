#!/bin/bash

# Get available audio devices
get_audio_devices() {
    wpctl status | sed -n '/Audio/,/Video\|Settings/p' | sed -n '/Devices:/,/^[[:space:]]*├─\|^[[:space:]]*└─/p' | grep -E "^\s*│\s*[0-9]+\." | head -20
}

# Get current default sink name to match against devices
get_current_default() {
    wpctl status | grep -A 10 "Default Configured Devices:" | grep "Audio/Sink" | sed 's/.*Audio\/Sink[[:space:]]*//'
}

# Get all sinks to find device-to-sink mapping
get_all_sinks() {
    wpctl status | sed -n '/Sinks:/,/Sources:\|Filters:/p' | grep -E "^\s*│\s*[\*[:space:]]*[0-9]+\."
}

# Get sinks from Filters section (like EarPods)
get_filter_sinks() {
    wpctl status | sed -n '/Filters:/,/Streams:\|^[[:space:]]*└─/p' | grep "Audio/Sink"
}

# Build device mapping and menu
build_menu() {
    mapfile -t devices < <(get_audio_devices)
    current_default=$(get_current_default)
    mapfile -t all_sinks < <(get_all_sinks)
    mapfile -t filter_sinks < <(get_filter_sinks)

    declare -gA device_to_sink

    # Build device to sink mapping
    for device in "${devices[@]}"; do
        device_id=$(echo "$device" | grep -o "[0-9]\+" | head -1)
        device_name=$(echo "$device" | sed 's/^[[:space:]]*│[[:space:]]*[0-9]*\.[[:space:]]*//' | sed 's/[[:space:]]*\[.*\][[:space:]]*$//' | xargs)
        
        # Look for corresponding sink in regular sinks
        corresponding_sink=""
        for sink in "${all_sinks[@]}"; do
            sink_name=$(echo "$sink" | sed 's/^[[:space:]]*│[[:space:]]*[\*[:space:]]*[0-9]*\.[[:space:]]*//' | sed 's/[[:space:]]*\[.*\][[:space:]]*$//' | xargs)
            if [[ "$sink_name" == *"$device_name"* ]] || [[ "$device_name" == *"$sink_name"* ]]; then
                corresponding_sink=$(echo "$sink" | grep -o "[0-9]\+" | head -1)
                break
            fi
        done
        
        # If not found in regular sinks, check filter sinks
        if [[ -z "$corresponding_sink" ]]; then
            for filter_sink in "${filter_sinks[@]}"; do
                if [[ "$filter_sink" == *"$device_name"* ]]; then
                    corresponding_sink=$(echo "$filter_sink" | grep -o "[0-9]\+" | head -1)
                    break
                fi
            done
        fi
        
        # Check if this device is currently active
        is_active=""
        if [[ "$current_default" == *"$device_name"* ]] || [[ "$device_name" == *"Bose"* && "$current_default" == *"Bose"* ]] || [[ "$device_name" == *"EarPods"* && "$current_default" == *"EarPods"* ]]; then
            is_active="* "
        fi
        
        echo "$is_active$device_name"
        if [[ -n "$corresponding_sink" ]]; then
            device_to_sink["$device_name"]="$corresponding_sink"
        else
            device_to_sink["$device_name"]="$device_id"
        fi
    done
}

# If no arguments, output menu items
if [[ $# -eq 0 ]]; then
    build_menu
# If argument provided, switch to selected device
else
    chosen="$1"
    build_menu > /dev/null  # Build mapping without output
    
    # Remove asterisk and get device name
    device_name=$(echo "$chosen" | sed 's/^\* //')
    sink_id="${device_to_sink[$device_name]}"
    
    if [[ -n "$sink_id" ]]; then
        wpctl set-default "$sink_id"
        notify-send "Audio Device" "Switched to: $device_name" -i audio-headphones
    else
        notify-send "Audio Device" "Could not find sink for: $device_name" -i dialog-error
    fi
fi
