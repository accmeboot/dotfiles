#!/usr/bin/env bash

run() {
  hyprctl -q dispatch exec "$1" 
}

if [ "$#" -gt 0 ]; then
  selection_clean=$(echo "$1" | sed 's/^[^ ]* //')

    case "$selection_clean" in
      "Audio")
        run "${TERMINAL:-ghostty} --class=com.accme.float --command='wiremix -v output'"
        ;;
      "System Monitor")
        run "${TERMINAL:-ghostty} --class=com.accme.float --command=btop"
        ;;
      "Files")
        run "${TERMINAL:-ghostty} --class=com.accme.float --command=yazi"
        ;;
      "Steam")
        run "steam"
        ;;
      "Tray")
        run "${TERMINAL:-ghostty} --class=com.accme.float --command=tray-tui"
        ;;
      "Browser")
        run "zen"
        ;;
      "Terminal")
        run "${TERMINAL:-ghostty}"
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
        run "${TERMINAL:-ghostty} --command='tmux new -s CONFIG -c ~/dotfiles'"
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
