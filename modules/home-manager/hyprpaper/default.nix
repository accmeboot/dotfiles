{ config, pkgs, lib, ... }:
{
  services.hyprpaper = {
    enable = true;
    settings = {
      ipc = "on";
      splash = false;
      splash_offset = 2.0;

      preload =
        [ config.stylix.image ];

      wallpaper = [
        ",${config.stylix.image}"
      ];
    };
  };
}
