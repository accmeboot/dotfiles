#!/bin/bash

get_cpu_temp() {
    # Try AMD Tctl first
    temp=$(sensors | grep 'Tctl:' | awk '{print $2}' | sed 's/[^0-9.]*//g' | head -1)
    
    # If Tctl not found, try Intel Package id
    if [ -z "$temp" ]; then
        temp=$(sensors | grep 'Package id' | awk '{print $4}' | sed 's/[^0-9.]*//g' | head -1)
    fi
    
    # If Package id not found, try first Core temperature
    if [ -z "$temp" ]; then
        temp=$(sensors | grep 'Core [0-9]*:' | head -1 | awk '{print $3}' | sed 's/[^0-9.]*//g')
    fi
    
    echo "$temp"
}

temp=$(get_cpu_temp)
temp=${temp%.*}  # Remove decimal part if present

if [ "$temp" -lt 50 ]; then
  class="normal"
elif [ "$temp" -lt 65 ]; then
  class="medium" 
else
  class="high"
fi

echo "{\"text\":\"$temp\",\"class\":\"$class\"}"
