#!/bin/bash

nvidia-smi --query-gpu=temperature.gpu --format=csv,noheader
