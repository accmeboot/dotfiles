#!/bin/bash

set -e

echo "Linking NixOS configuration..."
if [ -f /etc/nixos/configuration.nix ]; then sudo mv /etc/nixos/configuration.nix /etc/nixos/configuration.nix.backup; fi
sudo ln -sfn $HOME/dotfiles/linux/nixos/configuration.nix /etc/nixos/configuration.nix

echo "All done!"
