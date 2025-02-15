#!/bin/bash

# If an argument is passed, execute the command and exit
if [ "$#" -gt 0 ]; then
    case $1 in
        shutdown)
            shutdown now
            ;;
        reboot)
            reboot
            ;;
        sleep)
            systemctl suspend
            ;;
        lock)
            swaylock -f -c '#3a3735' &
            ;;
        logout)
            sway exit
            ;;
    esac
    # Exit without output to make rofi close
    exit 0
fi

# If no arguments, show the menu
declare -A options

options[shutdown]=system-shutdown
options[reboot]=system-reboot
options[sleep]=system-suspend
options[lock]=system-lock-screen
options[logout]=system-log-out

for key in "${!options[@]}"
do
    echo -en "$key\0icon\x1f${options[$key]}\n"
done
