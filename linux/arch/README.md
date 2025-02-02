## [Hyprland](https://hyprland.org/)

1. Install arch linux with archinstall choose hyprland, select nvidia proprietary drivers;
2. Follow this guide to make nvidia work [guide](https://wiki.hyprland.org/Nvidia/#how-to-get-hyprland-to-possibly-work-on-nvidia)
3. Follow this guide to install [asus rog software](https://wiki.hyprland.org/Asus_ROG/#asus-rog) **or run `bash $HOME/dotfiles/linux/hyprland/bootstrap-asus.sh`**
4. Clone dotfiles and run `bash $HOME/dotfiles/linux/hyprland/bootstrap.sh`
5. Follow this [guide](https://wiki.archlinux.org/title/silent_boot) to make boot silent.
6. Install `plymouth` for displaying wendor logo [guide](https://wiki.archlinux.org/title/plymouth)
7. Install [cattpuccin for sddm](https://github.com/catppuccin/sddm) just follow the instructions,
8. Install [Catppuccin GTK](https://github.com/catppuccin/gtk).
9. Install icons for gtk https://github.com/PapirusDevelopmentTeam/papirus-icon-theme?tab=readme-ov-file

## Arch Important Notes

> /boot/loader/entries/(date-format)\_linux.conf
> `quiet splash loglevel=3 systemd.show_status=auto rd.udev.log_level=3 vt.global_cursor_default=0 nvidia_drm.modeset=1 nvidia.NVreg_RegistryDwords=EnableBrightnessControl=1 nvidia.NVreg_PreserveVideoMemoryAllocations=1`

> /etc/mkinitcpio.conf
> `MODULES=(nvidia nvidia_modeset nvidia_uvm nvidia_drm)
 BINARIES=()
 FILES=()
 HOOKS=(base systemd plymouth autodetect keyboard keymap modconf block filesystems fsck)`

**Need to run `sudo mkinitcpio -P` after changing mkinitcpio.conf**
