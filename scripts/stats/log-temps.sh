#!/usr/bin/env bash

while true
do
  echo CPU: $(~/dotfiles/scripts/stats/cpu-temp.sh) GPU: $(~/dotfiles/scripts/stats/gpu-temp.sh)
  sleep 1
done
