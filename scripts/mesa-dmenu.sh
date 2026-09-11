#!/bin/sh
sock="${XDG_RUNTIME_DIR:?}/mesa-shell-dmenu.sock"
[ -S "$sock" ] || exit 1
{ cat; printf '\0'; } | socat -t 86400 - "UNIX-CONNECT:$sock,shut-none"
