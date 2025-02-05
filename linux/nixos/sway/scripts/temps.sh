# Get CPU temperature
CPU_TEMP=$(sensors | grep 'Tctl:' | awk '{print $2}' | sed 's/[^0-9.]*//g')

# Get GPU temperature
GPU_TEMP=$(sensors | awk '/junction/ {if (!found) {print $2; found=1}}')

# Get audio volume
VOLUME=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | grep 'Volume:' | awk '{print $2 * 100}')

# Get audio status
IS_MUTED=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | grep -c MUTED)

DATE=$(date "+%H:%M:%S")

# Print the temperatures
echo "  +${CPU_TEMP}°C  󰘚 ${GPU_TEMP}  ${DATE} $(if [ $IS_MUTED = 1 ]; then echo " "; else echo " "; fi)${VOLUME}%"
