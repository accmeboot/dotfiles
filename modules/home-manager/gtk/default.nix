{ config, pkgs, ... }:
{
  gtk = {
    enable = true;
    iconTheme = {
      name = "Reversal";
      package = pkgs.reversal-icon-theme;
    };
    cursorTheme = {
      name = "capitaine-cursors";
      package = pkgs.capitaine-cursors;
      size = 16;
    };
  };
}
