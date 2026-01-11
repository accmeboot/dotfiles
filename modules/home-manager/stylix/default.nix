{ pkgs, lib, config, inputs, ... }: {
  options.stylix.desktop = {
    enableFonts = lib.mkEnableOption "custom fonts" // { default = true; };
    enableIcons = lib.mkEnableOption "icon theme" // { default = true; };
    enableCursor = lib.mkEnableOption "cursor theme" // { default = true; };
    enableWallpaper = lib.mkEnableOption "wallpaper" // { default = true; };
  };

  options.stylix.theme = {
    borderRadius = lib.mkOption { default = 4; };
    borderWidth = lib.mkOption { default = 2; };
    opacity = lib.mkOption { default = 1.0; };
    spacing = {
      xs = lib.mkOption { default = 4; };
      s = lib.mkOption { default = 8; };
      m = lib.mkOption { default = 12; };
      xxl = lib.mkOption { default = 24; };
      xxs = lib.mkOption { default = 32; };
    };
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
          package = pkgs.nerd-fonts.meslo-lg;
          name = "MesloLGL Nerd Font";
        };
        sizes = {
          applications = 10;
          desktop = 10;
          popups = 12;
          terminal = 12;
        };
      };

      cursor = lib.mkIf config.stylix.desktop.enableCursor {
        package = pkgs.capitaine-cursors;
        name = "capitaine-cursors";
        size = 16;
      };

      icons = lib.mkIf config.stylix.desktop.enableIcons {
        enable = true;
        package = pkgs.papirus-icon-theme;
        dark = "Papirus-Dark";
        light = "Papirus-Light";
      };
    };
  };
}
