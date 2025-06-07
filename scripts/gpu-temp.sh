#!/bin/bash

temp=$(sensors | awk '/edge/ {if (!found) {print int($2); found=1}}')

if [ "$temp" -lt 50 ]; then
  class="normal"
elif [ "$temp" -lt 65 ]; then
  class="medium"
else
  class="high" 
fi

echo "{\"text\":\"$temp\",\"class\":\"$class\"}"
