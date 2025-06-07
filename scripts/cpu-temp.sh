#!/bin/bash

temp=$(sensors | grep 'Tctl:' | awk '{print int($2)}' | sed 's/[^0-9.]*//g')

if [ "$temp" -lt 50 ]; then
  class="normal"
elif [ "$temp" -lt 65 ]; then
  class="medium" 
else
  class="high"
fi

echo "{\"text\":\"$temp\",\"class\":\"$class\"}"
