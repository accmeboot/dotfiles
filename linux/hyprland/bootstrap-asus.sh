sudo pacman-key --recv-keys 8F654886F17D497FEFE3DB448B15A6B0E9A3FA35
sudo pacman-key --finger 8F654886F17D497FEFE3DB448B15A6B0E9A3FA35
sudo pacman-key --lsign-key 8F654886F17D497FEFE3DB448B15A6B0E9A3FA35
sudo pacman-key --finger 8F654886F17D497FEFE3DB448B15A6B0E9A3FA35

echo "[g14]" | sudo tee -a /etc/pacman.conf
echo "Server = https://arch.asus-linux.org" | sudo tee -a /etc/pacman.conf

sudo pacman -Syu

sudo pacman -S asusctl power-profiles-daemon supergfxctl switcheroo-control rog-control-center

systemctl enable --now power-profiles-daemon.service
systemctl enable --now supergfxd
systemctl enable --now switcheroo-control

