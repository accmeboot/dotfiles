#!/bin/bash

get_cpu_temp() {
    temp=$(sensors | grep 'Tctl:' | awk '{print $2}' | sed 's/[^0-9.]*//g' | head -1)
    
    if [ -z "$temp" ]; then
        temp=$(sensors | grep 'Package id' | awk '{print $4}' | sed 's/[^0-9.]*//g' | head -1)
    fi
    
    if [ -z "$temp" ]; then
        temp=$(sensors | grep 'Core [0-9]*:' | head -1 | awk '{print $3}' | sed 's/[^0-9.]*//g')
    fi
    
    echo "$temp"
}

temp=$(get_cpu_temp)
temp=${temp%.*}  # Remove decimal part if present

echo "{\"text\":\"$temp\"}"
