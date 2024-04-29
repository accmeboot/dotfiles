#!/bin/bash

set -e

echo "Linking dotfiles..."

if [ -d $HOME/.config/hypr ]; then rm -r $HOME/.config/hypr; fi
ln -sfn $HOME/dotfiles/linux/hyprland/hypr/ $HOME/.config/hypr

if [ -d $HOME/.config/rofi ]; then rm -r $HOME/.config/rofi; fi
ln -sfn $HOME/dotfiles/linux/hyprland/rofi/ $HOME/.config/rofi

if [ -d $HOME/.config/waybar ]; then rm -r $HOME/.config/waybar; fi
ln -sfn $HOME/dotfiles/linux/hyprland/waybar/ $HOME/.config/waybar

echo "Installing dependencies..."
dependencies=(waybar rofi bluez bluez-utils blueman brightnessctl wl-clipboard hyprpaper hyprlock xclip nemo nwg-look grim slurp pavucontrol papirus-icon-theme pacman-contrib cmake ranger)
for pkg in "${dependencies[@]}"; do
    if ! pacman -Qs $pkg > /dev/null; then
        sudo pacman -S $pkg
    else
        echo "$pkg is already installed"
    fi
done

echo "Enabling bluetooth..."
systemctl enable bluetooth.service
systemctl start bluetooth.service 

echo "Installing yay..."
if ! command -v yay &> /dev/null; then
    sudo pacman -S --needed git base-devel
    git clone https://aur.archlinux.org/yay-bin.git
    cd yay-bin
    makepkg -si
    cd ..
    rm -rf yay-bin
else
    echo "yay is already installed"
fi


echo "All done!"
