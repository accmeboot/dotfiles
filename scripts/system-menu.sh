#!/usr/bin/env bash

run() {
  hyprctl -q dispatch exec "$1" 
}

if [ "$#" -gt 0 ]; then

    case $1 in
      "Audio")
        run "${TERMINAL:-wezterm} -e --class com.accme.float wiremix -v output"
        ;;
      "System Monitor")
        run "${TERMINAL:-wezterm} -e --class com.accme.float htop"
        ;;
      "Files")
        run "${TERMINAL:-wezterm} -e --class com.accme.float yazi"
        ;;
      "Steam")
        run "steam"
        ;;
      "Browser")
        run "brave"
        ;;
      "Terminal")
        run "${TERMINAL:-wezterm}"
        ;;
      "Run")
        run "rofi -show run"
        ;;
      "Applications")
        run "rofi -show drun"
        ;;
      "Shutdown")
        run "shutdown now"
        ;;
      "Reboot")
        run "reboot"
        ;;
      "Sleep")
        run "hyprlock & systemctl suspend"
        ;;
      "Lock")
        run "pidof hyprlock || hyprlock"
        ;;
      "Configuration")
        run "${TERMINAL:-wezterm} -e tmux new -s CONFIG -c ~/dotfiles"
        ;;
      "Light Mode")
        run "set-light-theme"
        ;;
      "Dark Mode")
        run "set-dark-theme"
        ;;
    esac
    # Exit without output to make rofi close
    exit 0
fi

# If no arguments, show the menu
echo -en "Browser\0icon\x1fbrave-browser\n"
echo -en "Files\0icon\x1ffolder\n"
echo -en "Steam\0icon\x1fsteam\n"
echo -en "Applications\0icon\x1fapplication-x-executable\n"
echo -en "Shutdown\0icon\x1fsystem-shutdown\n"
echo -en "Reboot\0icon\x1fsystem-reboot\n"
echo -en "Sleep\0icon\x1fsystem-suspend\n"
echo -en "Lock\0icon\x1fsystem-lock-screen\n"
echo -en "Audio\0icon\x1faudio-volume-high\n"
echo -en "System Monitor\0icon\x1fhtop\n"
echo -en "Terminal\0icon\x1futilities-terminal\n"
echo -en "Run\0icon\x1fsystem-run\n"
echo -en "Configuration\0icon\x1fpreferences-system\n"
echo -en "Light Mode\0icon\x1fweather-clear\n"
echo -en "Dark Mode\0icon\x1fweather-clear-night\n"
