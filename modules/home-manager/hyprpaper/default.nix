{ config, pkgs, lib, ... }:
{
  services.hyprpaper = {
    enable = true;
    settings = {
      ipc = "on";
      splash = false;
      splash_offset = 2.0;

      preload =
        [ "${../../../assets/wallpapers/forest-gruvbox.png}" ];

      wallpaper = [
        ",${../../../assets/wallpapers/forest-gruvbox.png}"
      ];
    };
  };
}
