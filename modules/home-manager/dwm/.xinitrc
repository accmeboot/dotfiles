#!/bin/sh

# Set display configuration
xrandr --output DP-2 --mode 2560x1440 --rate 240 &

nm-applet &
blueman-applet &

# Set background wallpaper
feh --bg-fill ~/dotfiles/assets/wallpapers/evangelion.png &

while true; do
	DATE="$(date +'%a %d %H:%M')"
	xsetroot -name "$DATE"
	sleep 2
done &

exec dwm
