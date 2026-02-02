#!/usr/bin/env bash

run() {
  setsid -f sh -c "$*" >/dev/null 2>&1
}

if [ "$#" -gt 0 ]; then
  selection_clean=$(echo "$1" | sed 's/^[^ ]* //')

    case "$selection_clean" in
      "Audio")
        run "${TERMINAL:-wezterm} start -e wiremix -v output"
        ;;
      "System Monitor")
        run "${TERMINAL:-wezterm} start -e btop"
        ;;
      "Files")
        run "${TERMINAL:-wezterm} start -e yazi"
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
      "Shutdown")
        run "shutdown now"
        ;;
      "Reboot")
        run "reboot"
        ;;
      "Sleep")
        run "systemctl suspend"
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
