# Get CPU temperature
CPU_TEMP=$(sensors | grep 'Tctl:' | awk '{print $2}' | sed 's/[^0-9.]*//g')

# Get GPU temperature
GPU_TEMP=$(sensors | awk '/junction/ {if (!found) {print $2; found=1}}')

DATE=$(date "+%H:%M:%S")

# Print the temperatures
echo "  +${CPU_TEMP}°C  󰘚 ${GPU_TEMP}  ${DATE} "
