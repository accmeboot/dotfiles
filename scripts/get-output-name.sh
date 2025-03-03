#!/bin/bash

wpctl inspect @DEFAULT_SINK@ | awk -F'"' '/alsa.card_name/ {print $2}'
