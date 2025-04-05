{ config, pkgs, ... }: {
  stylix = {
    enable = true;
    image = ../../../assets/wallpapers/bay.jpeg;
    polarity = "dark";

    # base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-dark-hard.yaml";
    base16Scheme = import ./src/schemes/dawn.nix;

    targets = {
      kitty.enable = false;
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
        package = pkgs.nerdfonts;
        name = "SFMono Nerd Font";
      };
      sizes = {
        applications = 9.5;
        desktop = 9.5;
        popups = 9.5;
      };
    };
  };
}
