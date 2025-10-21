#!/usr/bin/env bash

IFS=':'

SCRIPT_DIR="$HOME/dotfiles/scripts"

entries=" Audio\n󰄩 System Monitor\n Files\n Steam\n󰖟 Browser\n Terminal\n󱓞 Drun\n󰤆 Shutdown\n Reboot\n󰒲 Sleep\n Lock"

get_selection() {
  echo -e "$entries" | "$SCRIPT_DIR/launcher/show-launcher.sh"
}

run() {
  exec systemd-run --user -- sh -c "$1"
}

if selection=$( get_selection ); then
  selection_clean=$(echo "$selection" | sed 's/^[^ ]* //')
  
  case "$selection_clean" in
    "Audio")
      run "${TERMINAL:-kitty} wiremix"
      ;;
    "System Monitor")
      run "${TERMINAL:-kitty} btop"
      ;;
    "Files")
      run "${TERMINAL:-kitty} yazi"
      ;;
    "Steam")
      run "steam"
      ;;
    "Browser")
      run "zen"
      ;;
    "Terminal")
      run "${TERMINAL:-kitty}"
      ;;
    "Drun")
      exec "$SCRIPT_DIR/launcher/drun.sh"
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
    *)
      exit 1
      ;;
  esac
fi
