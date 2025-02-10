#!/bin/bash
sensors | awk '/edge/ {if (!found) {print int($2); found=1}}'
