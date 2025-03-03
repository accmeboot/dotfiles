#!/bin/bash

# Check if Nix is already installed
if command -v nix >/dev/null 2>&1; then
    echo "Nix is already installed"
else
    echo "Installing Nix..."
    sh <(curl -L https://nixos.org/nix/install)
fi

# Enable flakes
echo "Enabling flakes..."
mkdir -p ~/.config/nix
if ! grep -q "experimental-features" ~/.config/nix/nix.conf 2>/dev/null; then
    echo "experimental-features = nix-command flakes" >> ~/.config/nix/nix.conf
fi

