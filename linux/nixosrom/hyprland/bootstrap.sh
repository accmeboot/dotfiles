#!/bin/bash

set -e

echo "Linking dotfiles..."

if [ -d $HOME/.config/hypr ]; then rm -r $HOME/.config/hypr; fi
ln -sfn $HOME/dotfiles/linux/nixosrom/hyprland/hypr/ $HOME/.config/hypr

if [ -d $HOME/.config/rofi ]; then rm -r $HOME/.config/rofi; fi
ln -sfn $HOME/dotfiles/linux/nixosrom/hyprland/rofi/ $HOME/.config/rofi

if [ -d $HOME/.config/waybar ]; then rm -r $HOME/.config/waybar; fi
ln -sfn $HOME/dotfiles/linux/nixosrom/hyprland/waybar/ $HOME/.config/waybar

echo "All done!"
