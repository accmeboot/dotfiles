#!/bin/bash

get_gpu_temp() {
    if command -v nvidia-smi >/dev/null 2>&1; then
        temp=$(nvidia-smi --query-gpu=temperature.gpu --format=csv,noheader,nounits 2>/dev/null | head -1)
        if [ -n "$temp" ] && [ "$temp" != "0" ]; then
            echo "$temp"
            return
        fi
    fi
    
    temp=$(sensors | awk '/edge/ {if (!found) {print int($2); found=1}}')
    
    if [ -z "$temp" ]; then
        temp=$(sensors | grep -i 'gpu' | awk '{print $2}' | sed 's/[^0-9.]*//g' | head -1)
    fi
    
    if [ -z "$temp" ]; then
        temp=$(sensors | grep 'Core [0-9]*:' | awk '{print $3}' | sed 's/[^0-9.]*//g' | sort -nr | head -1)
    fi
    
    echo "$temp"
}

temp=$(get_gpu_temp)

if [ -z "$temp" ] || [ "$temp" = "0" ]; then
    echo "{\"text\":\"N/A\"}"
    exit 0
fi

echo "{\"text\":\"$temp\"}"
