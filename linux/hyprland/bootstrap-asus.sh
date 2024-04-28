#!/bin/bash

set -e

echo "Importing the ASUS Linux key..."
sudo pacman-key --recv-keys 8F654886F17D497FEFE3DB448B15A6B0E9A3FA35
sudo pacman-key --finger 8F654886F17D497FEFE3DB448B15A6B0E9A3FA35
sudo pacman-key --lsign-key 8F654886F17D497FEFE3DB448B15A6B0E9A3FA35
sudo pacman-key --finger 8F654886F17D497FEFE3DB448B15A6B0E9A3FA35

echo "Adding the ASUS Linux repository to pacman.conf..."
if ! grep -q "\[g14\]" /etc/pacman.conf; then
    echo "[g14]" | sudo tee -a /etc/pacman.conf
    echo "Server = https://arch.asus-linux.org" | sudo tee -a /etc/pacman.conf
fi

echo "Updating the package database and upgrading all packages..."
sudo pacman -Syu

echo "Installing the ASUS ROG software..."
sudo pacman -S asusctl power-profiles-daemon supergfxctl switcheroo-control rog-control-center

echo "Enabling the necessary services..."
for service in power-profiles-daemon.service supergfxd switcheroo-control; do
    if ! systemctl is-enabled --quiet "$service"; then
        echo "Enabling $service..."
        systemctl enable --now "$service"
    fi
done
