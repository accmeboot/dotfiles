#!/usr/bin/env bash

SCRIPT_DIR="$HOME/dotfiles/scripts"

# NixOS desktop entry directories
DESKTOP_DIRS=(
    "$HOME/.nix-profile/share/applications"
    "/run/current-system/sw/share/applications" 
    "$HOME/.local/share/applications"
)

# Check if desktop file should be displayed
is_displayable() {
    local file="$1"
    ! grep -q "^NoDisplay=true" "$file"
}

# Extract name from [Desktop Entry] section only
get_desktop_name() {
    local file="$1"
    awk '/^\[Desktop Entry\]/{in_main=1} /^\[/ && !/^\[Desktop Entry\]/{in_main=0} in_main && /^Name=/ && !/^Name\[/ {print substr($0,6); exit}' "$file"
}

# Extract exec command from [Desktop Entry] section only
get_desktop_exec() {
    local file="$1"
    awk '/^\[Desktop Entry\]/{in_main=1} /^\[/ && !/^\[Desktop Entry\]/{in_main=0} in_main && /^Exec=/ {print substr($0,6); exit}' "$file"
}

get_selection() {
    find "${DESKTOP_DIRS[@]}" -name "*.desktop" 2>/dev/null | while read file; do
        if is_displayable "$file"; then
            get_desktop_name "$file"
        fi
    done | sort -u | "$SCRIPT_DIR/launcher/show-launcher.sh"
}

if selection=$(get_selection); then
    # Find the desktop file with matching name and get its Exec command
    exec_cmd=""
    while IFS= read -r desktop_file; do
        [[ -r "$desktop_file" ]] || continue
        
        if ! is_displayable "$desktop_file"; then
            continue
        fi
        
        name=$(get_desktop_name "$desktop_file")
        if [[ "$name" == "$selection" ]]; then
            exec_cmd=$(get_desktop_exec "$desktop_file")
            break
        fi
    done < <(find "${DESKTOP_DIRS[@]}" -name "*.desktop" 2>/dev/null)

    if [[ -n "$exec_cmd" ]]; then
        # Clean up desktop entry field codes
        exec_cmd=$(echo "$exec_cmd" | sed 's/ %[fFuUdDnNickvm]//g')
        exec systemd-run --user --quiet -- sh -c "$exec_cmd"
    fi
fi
