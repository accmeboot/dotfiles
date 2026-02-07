#!/bin/sh

xrandr --output DisplayPort-1 --mode 2560x1440 --rate 240 &

feh --bg-fill ~/dotfiles/assets/wallpapers/evangelion.png &

SCRIPT_DIR="$HOME/dotfiles/modules/home-manager/dwm/scripts"

while true; do
	VOLUME="$($SCRIPT_DIR/get-volume.sh)"
	MIC="$($SCRIPT_DIR/get-mic.sh)"
	DATE="$(date +'%A %H:%M')"
	BATTERY="$($SCRIPT_DIR/get-battery.sh)"

	xsetroot -name "   $VOLUME%  󰇙   $MIC%${BATTERY:+  󰇙    $BATTERY%}  󰇙  $DATE"

	sleep 1
done &

exec dwm
