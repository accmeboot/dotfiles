# Get CPU temperature
CPU_TEMP=$(sensors | grep 'Tctl:' | awk '{print $2}' | sed 's/[^0-9.]*//g')

# Get GPU temperature
GPU_TEMP=$(sensors | awk '/junction/ {if (!found) {print $2; found=1}}')

# Get audio status
IS_MUTED=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | grep -c MUTED)

# Get audio device
AUDIO_DEVICE=$(wpctl status | grep "\*" | head -1 | awk '{for(i=4; i<=NF; i++) printf "%s ", $i; print ""}')

# Get formatted audio device
FORMATTED_AUDIO_DEVICE=$(echo $AUDIO_DEVICE | awk '{print $1 " " $2 " " $3 " " $NF * 100}')

# Get current time
DATE=$(date "+%H:%M:%S")

echo "$(if [ $IS_MUTED = 1 ]; then echo " "; else echo " "; fi) ${FORMATTED_AUDIO_DEVICE}%   +${CPU_TEMP}°C  󰘚 ${GPU_TEMP}  ${DATE} "
