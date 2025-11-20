#!/usr/bin/env bash

run() {
  niri msg action spawn-sh -- "$1"
}

if [ "$#" -gt 0 ]; then
  selection_clean=$(echo "$1" | sed 's/^[^ ]* //')

    case "$selection_clean" in
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
        run "sleep 0.1 && steam -system-composer"
        ;;
      "Browser")
        run "zen"
        ;;
      "Terminal")
        run "${TERMINAL:-wezterm}"
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
echo "󰖟 Browser"
echo " Files"
echo " Steam"
echo "󰤆 Shutdown"
echo " Reboot"
echo "󰒲 Sleep"
echo " Lock"
echo " Audio"
echo "󰄩 System Monitor"
echo " Terminal"
echo " Configuration"
echo "󰖨 Light Mode"
echo "󰖔 Dark Mode"
