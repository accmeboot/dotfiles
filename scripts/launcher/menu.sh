#!/usr/bin/env bash

IFS=':'

SCRIPT_DIR="$HOME/dotfiles/scripts"

entries=" Audio\n󰄩 System Monitor\n Files\n Steam\n󰖟 Browser\n Terminal\n󱓞 Drun\n󰝘 Applications\n󰤆 Shutdown\n Reboot\n󰒲 Sleep\n Lock\n Configuration\n󰖨 Light Mode\n Dark Mode"

get_selection() {
  echo -e "$entries" | "$SCRIPT_DIR/launcher/show-launcher.sh"
}

run() {
  exec systemd-run --user --quiet -- sh -c "$1"
}

if selection=$( get_selection ); then
  selection_clean=$(echo "$selection" | sed 's/^[^ ]* //')
  
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
    "Browser")
      run "brave"
      ;;
    "Terminal")
      run "${TERMINAL:-ghostty}"
      ;;
    "Drun")
      exec "$SCRIPT_DIR/launcher/drun.sh"
      ;;
    "Applications")
      exec "$SCRIPT_DIR/launcher/apps.sh"
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
      run "${TERMINAL:-ghostty} --command='tmux new -s CONFIG -c ~/dotfiles'"
      ;;
    "Light Mode")
      run "set-light-theme"
      ;;
    "Dark Mode")
      run "set-dark-theme"
      ;;
    *)
      exit 1
      ;;
  esac
fi
