#!/bin/bash

set -e

echo "Linking dotfiles..."

if [ -d $HOME/.config/hypr ]; then rm -r $HOME/.config/hypr; fi
ln -sfn $HOME/dotfiles/linux/nixos/hypr/ $HOME/.config/hypr

if [ -d $HOME/.config/rofi ]; then rm -r $HOME/.config/rofi; fi
ln -sfn $HOME/dotfiles/linux/nixos/rofi/ $HOME/.config/rofi

if [ -d $HOME/.config/waybar ]; then rm -r $HOME/.config/waybar; fi
ln -sfn $HOME/dotfiles/linux/nixos/waybar/ $HOME/.config/waybar

if [ -d $HOME/.config/sway ]; then rm -r $HOME/.config/sway; fi
ln -sfn $HOME/dotfiles/linux/nixos/sway/ $HOME/.config/sway

chmod +x $HOME/dotfiles/linux/nixos/sway/scripts/temps.sh

echo "Linking NixOS configuration..."
if [ -f /etc/nixos/configuration.nix ]; then sudo mv /etc/nixos/configuration.nix /etc/nixos/configuration.nix.backup; fi
sudo ln -sfn $HOME/dotfiles/linux/nixos/configuration.nix /etc/nixos/configuration.nix

echo "All done!"
