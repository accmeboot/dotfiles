#!/bin/bash

VALUE=$(brightnessctl g)

notify-send -a brightness -h int:value:"$VALUE" -h string:x-canonical-private-synchronous:brightness "󰍹 "
