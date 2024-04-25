ln -sfn ~/dotfiles/hyprland/hypr/ ~/.config/hypr
ln -sfn ~/dotfiles/hyprland/rofi/ ~/.config/rofi
ln -sfn ~/dotfiles/hyprland/waybar/ ~/.config/waybar

sudo pacman -S waybar rofi bluez bluez-utils blueman brightnessctl wl-clipboard hyprpaper hyprlock xclip nemo nwg-look grim slurp pavucontrol papirus-icon-theme

systemctl enable bluetooth.service
systemctl start bluetooth.service 
