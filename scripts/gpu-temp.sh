#!/bin/bash

get_gpu_temp() {
    # Try nvidia-smi first (best for NVIDIA GPUs)
    if command -v nvidia-smi >/dev/null 2>&1; then
        temp=$(nvidia-smi --query-gpu=temperature.gpu --format=csv,noheader,nounits 2>/dev/null | head -1)
        if [ -n "$temp" ] && [ "$temp" != "0" ]; then
            echo "$temp"
            return
        fi
    fi
    
    # Fallback to sensors edge pattern
    temp=$(sensors | awk '/edge/ {if (!found) {print int($2); found=1}}')
    
    # If edge not found, try other GPU patterns
    if [ -z "$temp" ]; then
        temp=$(sensors | grep -i 'gpu' | awk '{print $2}' | sed 's/[^0-9.]*//g' | head -1)
    fi
    
    # Final fallback to highest core temperature
    if [ -z "$temp" ]; then
        temp=$(sensors | grep 'Core [0-9]*:' | awk '{print $3}' | sed 's/[^0-9.]*//g' | sort -nr | head -1)
    fi
    
    echo "$temp"
}

temp=$(get_gpu_temp)

# Handle case where no temperature found
if [ -z "$temp" ] || [ "$temp" = "0" ]; then
    echo "{\"text\":\"N/A\",\"class\":\"normal\"}"
    exit 0
fi

if [ "$temp" -lt 50 ]; then
  class="normal"
elif [ "$temp" -lt 65 ]; then
  class="medium"
else
  class="high" 
fi

echo "{\"text\":\"$temp\",\"class\":\"$class\"}"
