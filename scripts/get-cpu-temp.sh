#!/bin/bash
sensors | grep 'Tctl:' | awk '{print int($2)}' | sed 's/[^0-9.]*//g'
