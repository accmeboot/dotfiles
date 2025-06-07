#!/bin/bash

usage=$(free -m | awk '/^Mem:/ {printf "%d", $3/$2 * 100}')

if [ "$usage" -lt 50 ]; then
  class="normal"
elif [ "$usage" -lt 75 ]; then
  class="medium"
else
  class="high"
fi

echo "{\"text\":\"$usage\",\"class\":\"$class\"}"
