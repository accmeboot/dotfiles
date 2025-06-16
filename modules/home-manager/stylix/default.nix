{ config, pkgs, ... }: {
  stylix = {
    enable = true;
    image = ../../../assets/wallpapers/gruvbox_image40.png;
    polarity = "dark";

    base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-dark-hard.yaml";

    targets = {
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
        package = pkgs.inter;
        name = "Inter";
      };
      sizes = {
        applications = 11;
        desktop = 11;
        popups = 11;
        terminal = 11;
      };
    };
  };
}
