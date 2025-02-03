#!/bin/bash

sensors | awk '/edge/ {printf "%d\n", $2}'
