#!/bin/bash


monitors_state_dir=$HOME/.local/state/hyprmonitors
monitors_state_file=$monitors_state_dir/rc.log


if [ ! -d "$monitors_state_dir" ]; then
  mkdir -p "$monitors_state_dir"
fi

if [ -f "$monitors_state_file" ]; then
  > "$monitors_state_file"
fi


# Get the list of monitor names and sort them so the internal monitor is always first
monitors_output=$(hyprctl monitors | grep "Monitor " | awk '{print $2}')

if [ $? -ne 0 ]; then
  echo "Error: Failed to run hyprctl monitors" >&2
  exit 1
fi

monitors=$(echo "$monitors_output" | { grep "^eDP-" || true; } ; echo "$monitors_output" | { grep -v "^eDP-" | sort || true; })

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
    highest_mode=$(echo "$modes" | awk -F'@' '{if ($2 <= 240) print $0}' | head -n 1)

    # Extract the resolution
    resolution=$(echo "$highest_mode" | awk -F'@' '{print $1}')

    # Extract the width of the resolution
    width=$(echo "$resolution" | awk -F'x' '{print $1}')

    # Set the mode for the monitor
    hyprctl keyword monitor "${monitor}, ${highest_mode},${x_position}x0,1"

    echo "${monitor},${highest_mode},${x_position}x0,1" >> "$monitors_state_file"

    # Update the x position for the next monitor
    x_position=$((x_position + width))
done
