#!/bin/bash

case $1 in
    "up")
        swaymsg workspace prev
        ;;
    "down")
        swaymsg workspace next
        ;;
esac
