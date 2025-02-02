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
dependencies=(
    waybar 
    rofi 
    bluez 
    bluez-utils 
    blueman 
    brightnessctl 
    wl-clipboard 
    wlr-randr
    hyprpaper 
    hyprlock 
    xclip 
    nemo 
    nwg-look 
    grim 
    slurp 
    pavucontrol 
    papirus-icon-theme 
    pacman-contrib 
    cmake 
    zellij
    yazi 
    ffmpegthumbnailer 
    unarchiver 
    jq 
    poppler 
    fd 
    ripgrep 
    fzf 
    zoxide
    noto-fonts-emoji
    fastfetch
)
for pkg in "${dependencies[@]}"; do
    if ! pacman -Qs $pkg > /dev/null; then
        sudo pacman -S $pkg
    else
        echo "$pkg is already installed"
    fi
done
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

echo "Enabling nvidia services..."
sudo systemctl enable nvidia-suspend.service
sudo systemctl enable nvidia-hibernate.service
sudo systemctl enable nvidia-resume.service

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

echo "Installing AUR packages..."
aur_dependencies=(
  catppuccin-gtk-theme-mocha
  asusctl
)
for aur_pkg in "${aur_dependencies[@]}"; do
    if ! yay -Qs $aur_pkg > /dev/null; then
        yay -S $aur_pkg
    else
        echo "$aur_pkg is already installed"
    fi
done

echo "All done!"
