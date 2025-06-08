{ config, pkgs, ... }: {
  stylix = {
    enable = true;
    image = ../../../assets/wallpapers/desk-gruvbox-material.jpg;
    polarity = "dark";

    # base16Scheme = "${pkgs.base16-schemes}/share/themes/grayscale-dark.yaml";
    base16Scheme = import ./src/schemes/gruvbox.nix;

    targets = {
      kitty.enable = false;
      starship.enable = false;
      waybar.enable = false;
      mako.enable = false;
    };

    fonts = {
      serif = {
        package = pkgs.inter;
        name = "Inter";
      };
      sansSerif = {
        package = pkgs.inter;
        name = "Inter";
      };
      monospace = {
        package = pkgs.nerd-fonts.meslo-lg;
        name = "MesloLG";
      };
      sizes = {
        applications = 9.5;
        desktop = 9.5;
        popups = 9.5;
      };
    };
  };
}
