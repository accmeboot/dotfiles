echo "Linking dotfiles..."

if [ -d $HOME/.config/hypr ]; then rm -r $HOME/.config/hypr; fi
ln -sfn $HOME/dotfiles/linux/hyprland/hypr/ $HOME/.config/hypr

if [ -d $HOME/.config/rofi ]; then rm -r $HOME/.config/rofi; fi
ln -sfn $HOME/dotfiles/linux/hyprland/rofi/ $HOME/.config/rofi

if [ -d $HOME/.config/waybar ]; then rm -r $HOME/.config/waybar; fi
ln -sfn $HOME/dotfiles/linux/hyprland/waybar/ $HOME/.config/waybar

echo "Installing dependencies..."
sudo pacman -S waybar rofi bluez bluez-utils blueman brightnessctl wl-clipboard hyprpaper hyprlock xclip nemo nwg-look grim slurp pavucontrol papirus-icon-theme pacman-contrib cmake

echo "Enabling bluetooth..."
systemctl enable bluetooth.service
systemctl start bluetooth.service 

echo "All done!"
