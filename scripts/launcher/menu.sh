#!/usr/bin/env bash

IFS=':'

SCRIPT_DIR="$HOME/dotfiles/scripts"

entries=" Audio\n󰄩 System Monitor\n Files\n Steam\n󰖟 Browser\n Terminal\n󱓞 Drun\n󰝘 Applications\n󰤆 Shutdown\n Reboot\n󰒲 Sleep\n Lock\n Configuration"

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
      run "${TERMINAL:-kitty} --class com.accme.float wiremix -v output"
      ;;
    "System Monitor")
      run "${TERMINAL:-kitty} --class com.accme.float htop"
      ;;
    "Files")
      run "${TERMINAL:-kitty} --class com.accme.float yazi"
      ;;
    "Steam")
      run "steam"
      ;;
    "Browser")
      run "brave"
      ;;
    "Terminal")
      run "${TERMINAL:-kitty}"
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
      run "${TERMINAL:-kitty} tmux new -s CONFIG -c ~/dotfiles"
      ;;
    *)
      exit 1
      ;;
  esac
fi
