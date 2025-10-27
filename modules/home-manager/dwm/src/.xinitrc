#!/bin/sh

# Set display configuration
xrandr --output DP-2 --mode 2560x1440 --rate 240 &

nm-applet &
blueman-applet &

# Set background wallpaper
feh --bg-fill ~/dotfiles/assets/wallpapers/cyberpunk_catppuccin.jpg &

while true; do
	STATS="$(~/dotfiles/scripts/stats/get-stats.sh)"
	DATE="$(date +'%a %d %H:%M')"
	xsetroot -name "$STATS | $DATE"
	sleep 2
done &

exec dwm
