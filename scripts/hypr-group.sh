#!/bin/bash --posix

# ------------------------------------------------------------------------------
# Script to simulate the way i3 creates tabs, but in Hyprland!
# ---
# Version: 0.5.0
# ---
# Known issues:
# - Hyprland crashes when using this script with too many windows. Sounds like
#   a Hyprland issue, but if that gets too annoying for me I'll find some
#   workaround for this script.
# - Grouping does not work if the layout is too "deep".
# ------------------------------------------------------------------------------

# Set POSIX-compliant mode for security and unset possible overrides
# NOTE: This does not mean that we are restricted to POSIX-only constructs
# ------------------------------------------------------------------------
POSIXLY_CORRECT=1
set -o posix
readonly POSIXLY_CORRECT
export POSIXLY_CORRECT

# Set IFS explicitly. POSIX does not enforce whether IFS should be inherited
# from the environment, so it's safer to set it expliticly
# --------------------------------------------------------------------------
IFS=$' \t\n'
export IFS

# Set up fd 3 for discarding output, necessary for set -r
# -------------------------------------------------------
exec 3>/dev/null

# ------------------------------------------------------------------------------
# Options description:
#   -o pipefail: exit on error in any part of pipeline
#   -eE:         exit on any error, go through error handler
#   -u:          exit on accessing uninitialized variable
#   -r:          set bash restricted mode for security
# The restricted mode option necessitates the usage of tee
# instead of simple output redirection when writing to files
# ------------------------------------------------------------------------------
set -o pipefail -eEur

# Speed up script by not using unicode
# ------------------------------------
LC_ALL=C
LANG=C

# Check whether to group or ungroup windows
# -----------------------------------------
if hyprctl -j activewindow | jq -cr '.grouped' | grep -vFq '['
then
    # --------------------------------------------------------------------------
    # Ungroup current window group
    # --------------------------------------------------------------------------
    hyprctl dispatch togglegroup
else
    # --------------------------------------------------------------------------
    # Group all windows on focused workspace
    # --------------------------------------------------------------------------

    # Save original window's address
    # ------------------------------
    ORIGWINDOW="$(hyprctl -j activewindow | jq -cr '.address')"

    # Get current workspace's windows' addresses
    # ------------------------------------------
    WINDOWS="$(hyprctl -j clients | jq -cr ".[] | select(.workspace.id == $(hyprctl activeworkspace -j | jq -cr '.id')) | .address")"

    # If there's just one window, just group it normally for better UX
    # ----------------------------------------------------------------
    if [ "$(echo "$WINDOWS" | wc -l)" -eq 1 ]
    then
        hyprctl dispatch togglegroup
    else
        # Move to each window and try to group it every which way
        # -------------------------------------------------------
        window_args=""
        for window in $WINDOWS
        do
            window_args="$window_args dispatch focuswindow address:$window; dispatch moveintogroup l; dispatch moveintogroup r; dispatch moveintogroup u; dispatch moveintogroup d;"
        done
        # Group the first window
        # ----------------------
        batch_args="dispatch togglegroup;"

        # Group all other windows twice (once isn't enough in case of very
        # "deep" layouts". This ugly workaround could be fixed if hyprland
        # allowed moving into groups based on addresses and not positions
        # ----------------------------------------------------------------
        batch_args="$batch_args $window_args $window_args"

        # Also focus the original window at the very end
        # ----------------------------------------------
        batch_args="$batch_args dispatch focuswindow address:$ORIGWINDOW"

        # Execute the grouping using hyprctl --batch for performance
        # ----------------------------------------------------------
        hyprctl --batch "$batch_args"
    fi
fi
