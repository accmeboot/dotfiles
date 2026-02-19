#!/usr/bin/env bash

run() {
  hyprctl -q dispatch exec "$1" 
}

if [ "$#" -gt 0 ]; then
  selection_clean=$(echo "$1" | sed 's/^[^ ]* //')

    case "$selection_clean" in
      "Audio")
        run "${TERMINAL:-wezterm} start -e --class com.accme.float wiremix -v output"
        ;;
      "System Monitor")
        run "${TERMINAL:-wezterm} start -e --class com.accme.float btop"
        ;;
      "Files")
        run "${TERMINAL:-wezterm} start -e --class com.accme.float yazi"
        ;;
      "Steam")
        run "steam"
        ;;
      "Tray")
        run "${TERMINAL:-wezterm} start -e --class com.accme.float tray-tui"
        ;;
      "Browser")
        run "brave"
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
      "Lock")
        run "pidof hyprlock || hyprlock"
        ;;
      "Sleep")
        run "hyprlock & systemctl suspend"
        ;;
      "Configuration")
        run "${TERMINAL:-wezterm} start -e tmux new -s CONFIG -c ~/dotfiles"
        ;;
    esac
    # Exit without output to make rofi close
    exit 0
fi

# If no arguments, show the menu
echo "󰖟 Browser"
echo " Audio"
echo " Files"
echo "󱊖 Tray"
echo " Steam"
echo "󰤆 Shutdown"
echo " Reboot"
echo " Lock"
echo "󰒲 Sleep"
echo "󰄩 System Monitor"
echo " Terminal"
echo " Configuration"
