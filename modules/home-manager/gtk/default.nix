{ pkgs, ... }:
{
  gtk = {
    enable = true;
    iconTheme = {
      name = "Reversal";
      package = pkgs.reversal-icon-theme;
    };
  };
}
