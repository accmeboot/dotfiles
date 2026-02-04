{ pkgs, lib, config, inputs, ... }: {
  options.stylix.desktop = {
    enableFonts = lib.mkEnableOption "custom fonts" // { default = true; };
    enableCursor = lib.mkEnableOption "cursor theme" // { default = true; };
    enableWallpaper = lib.mkEnableOption "wallpaper" // { default = true; };
    enableIcons = lib.mkEnableOption "icon theme" // { default = true; };
  };

  config = {
    stylix = {
      enable = true;

      polarity = "dark";
      image = ../../../assets/wallpapers/evangelion.png;
      base16Scheme = import ./schemes/material-darker.nix;

      targets = { starship.enable = false; };

      fonts = lib.mkIf config.stylix.desktop.enableFonts {
        serif = {
          package =
            inputs.apple-fonts.packages.${pkgs.stdenv.hostPlatform.system}.sf-pro-nerd;
          name = "SFProDisplay Nerd Font";
        };
        sansSerif = {
          package =
            inputs.apple-fonts.packages.${pkgs.stdenv.hostPlatform.system}.sf-pro-nerd;
          name = "SFProDisplay Nerd Font";
        };
        monospace = {
          package =
            inputs.apple-fonts.packages.${pkgs.stdenv.hostPlatform.system}.sf-mono-nerd;
          name = "SFMono Nerd Font";
        };
        sizes = {
          applications = 10;
          desktop = 10;
          popups = 12;
          terminal = 12;
        };
      };

      icons = lib.mkIf config.stylix.desktop.enableIcons {
        enable = true;
        package = pkgs.papirus-icon-theme;
        dark = "Papirus";
        light = "Papirus";
      };
    };
  };
}
