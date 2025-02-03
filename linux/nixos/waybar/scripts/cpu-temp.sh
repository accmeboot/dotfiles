#!/bin/bash

sensors | awk '/Tctl/ {printf "%d\n", $2}'
