{ config, pkgs, lib, ... }:
{
  services.hyprpaper = {
    enable = true;
    settings = {
      ipc = "on";
      splash = false;
      splash_offset = 2.0;

      preload =
        [ "${../../../assets/wallpapers/villag-gruvbox-dark.png}" ];

      wallpaper = [
        ",${../../../assets/wallpapers/villag-gruvbox-dark.png}"
      ];
    };
  };
}
