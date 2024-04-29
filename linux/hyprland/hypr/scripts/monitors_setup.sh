#!/bin/bash

# Get the list of monitor names
monitors=$(hyprctl monitors | grep "Monitor " | awk '{print $2}')

# Initialize the x position
x_position=0

# Loop over each monitor
for monitor in $monitors
do
    # Get the output of hyprctl monitors for the current monitor
    output=$(hyprctl monitors | awk -v monitor="Monitor $monitor " '/Monitor /{p=0} $0~monitor{p=1} p')

    # Extract the modes, sort them by resolution and refresh rate in descending order
    modes=$(echo "$output" | grep "availableModes:" | cut -d: -f2 | tr ' ' '\n' | sort -t "@" -k1,1nr -k2,2nr)

    # Select the first mode with a refresh rate less than or equal to 240Hz
    highest_mode=$(echo "$modes" | awk -F'@' '{if ($2 <= 300) print $0}' | head -n 1)

    # Extract the resolution
    resolution=$(echo "$highest_mode" | awk -F'@' '{print $1}')

    # Extract the width of the resolution
    width=$(echo "$resolution" | awk -F'x' '{print $1}')

    # Set the mode for the monitor
    hyprctl keyword monitor "${monitor}, ${highest_mode},${x_position}x0,1"

    # Update the x position for the next monitor
    x_position=$((x_position + width))
done
