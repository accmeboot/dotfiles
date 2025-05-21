{ config, pkgs, ... }: {
  stylix = {
    enable = true;
    image = ../../../assets/wallpapers/bay.jpeg;
    polarity = "dark";

    # base16Scheme = "${pkgs.base16-schemes}/share/themes/rose-pine.yaml";
    base16Scheme = import ./src/schemes/dawn.nix;

    targets = {
      kitty.enable = false;
      starship.enable = false;
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
