#!/bin/bash

set -e

echo "Linking dotfiles..."

if [ -d $HOME/.config/rofi ]; then rm -r $HOME/.config/rofi; fi
ln -sfn $HOME/dotfiles/linux/nixos/rofi/ $HOME/.config/rofi

if [ -d $HOME/.config/sway ]; then rm -r $HOME/.config/sway; fi
ln -sfn $HOME/dotfiles/linux/nixos/sway/ $HOME/.config/sway

chmod +x $HOME/dotfiles/linux/nixos/sway/scripts/status-line.sh

echo "Linking NixOS configuration..."
if [ -f /etc/nixos/configuration.nix ]; then sudo mv /etc/nixos/configuration.nix /etc/nixos/configuration.nix.backup; fi
sudo ln -sfn $HOME/dotfiles/linux/nixos/configuration.nix /etc/nixos/configuration.nix

echo "All done!"
