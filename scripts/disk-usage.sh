#!/bin/bash

get_disk_usage() {
    # Get disk usage percentage for root filesystem
    usage=$(df -h / | awk 'NR==2{print $5}' 2>/dev/null | sed 's/%//')
    echo "$usage"
}

usage=$(get_disk_usage)

if [ -z "$usage" ] || [ "$usage" = "0" ]; then
    echo "N/A"
    exit 0
fi

echo "$usage"