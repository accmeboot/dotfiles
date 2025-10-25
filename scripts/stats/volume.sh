#!/bin/bash

wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{if ($3 == "[MUTED]") print int($2 * 100) "% [MUTED]"; else print int($2 * 100) "%"}'
