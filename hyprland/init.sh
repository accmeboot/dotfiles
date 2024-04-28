echo "Linking dotfiles..."

if [ -d ~/.config/hypr ]; then rm -r ~/.config/hypr; fi
ln -sfn ~/dotfiles/hyprland/hypr/ ~/.config/hypr

if [ -d ~/.config/rofi ]; then rm -r ~/.config/rofi; fi
ln -sfn ~/dotfiles/hyprland/rofi/ ~/.config/rofi

if [ -d ~/.config/waybar ]; then rm -r ~/.config/waybar; fi
ln -sfn ~/dotfiles/hyprland/waybar/ ~/.config/waybar

echo "Installing dependencies..."
sudo pacman -S waybar rofi bluez bluez-utils blueman brightnessctl wl-clipboard hyprpaper hyprlock xclip nemo nwg-look grim slurp pavucontrol papirus-icon-theme pacman-contrib cmake cpio meson

systemctl enable bluetooth.service
systemctl start bluetooth.service 
