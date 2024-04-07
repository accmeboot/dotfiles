#!/bin/bash

sensors | awk -F '[+°]' '/^Package id 0:/ {printf "%d\n", $2}'
