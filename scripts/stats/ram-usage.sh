#!/bin/bash

get_ram_usage() {
    # Get RAM usage percentage
    usage=$(free -m | awk 'NR==2{printf "%.0f", $3*100/$2}' 2>/dev/null)
    echo "$usage"
}

usage=$(get_ram_usage)

if [ -z "$usage" ] || [ "$usage" = "0" ]; then
    echo "N/A"
    exit 0
fi

echo "$usage"