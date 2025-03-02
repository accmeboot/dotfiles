{ config, pkgs, ... }:
{
  gtk = {
    enable = true;
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };
    cursorTheme = {
      name = "capitaine-cursors";
      package = pkgs.capitaine-cursors;
      size = 16;
    };
  };

  home = {
    stateVersion = "24.11";
    username = "accme";
    homeDirectory = "/home/accme";
  };
}
