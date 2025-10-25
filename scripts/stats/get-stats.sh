#!/usr/bin/env bash


SCRIPT_DIR="$HOME/dotfiles/scripts/stats"


cpu_temp=$("$SCRIPT_DIR/cpu-temp.sh" 2>&1)
gpu_temp=$("$SCRIPT_DIR/gpu-temp.sh" 2>&1)
ram_usage=$("$SCRIPT_DIR/ram-usage.sh" 2>&1)
disk_usage=$("$SCRIPT_DIR/disk-usage.sh" 2>&1)
volume=$("$SCRIPT_DIR/volume.sh" 2>&1)

[ -z "$cpu_temp" ] && cpu_temp="N/A"
[ -z "$gpu_temp" ] && gpu_temp="N/A"
[ -z "$ram_usage" ] && ram_usage="N/A"
[ -z "$disk_usage" ] && disk_usage="N/A"
[ -z "$volume" ] && volume="N/A"

stats="CPU: ${cpu_temp}°C  GPU: ${gpu_temp}°C  RAM: ${ram_usage}%  DISK: ${disk_usage}%  VOL: ${volume}"

echo "$stats"
