{ pkgs, lib, config, inputs, ... }: {
  options.stylix.desktop = {
    enableFonts = lib.mkEnableOption "custom fonts" // { default = true; };
    enableCursor = lib.mkEnableOption "cursor theme" // { default = true; };
    enableWallpaper = lib.mkEnableOption "wallpaper" // { default = true; };
    enableIcons = lib.mkEnableOption "icon theme" // { default = true; };

    opacity = lib.mkOption {
      type = lib.types.float;
      default = 0.9;
      description = "System wide opacity value";
    };

    opacityHex = lib.mkOption {
      type = lib.types.str;
      readOnly = true;
      default = let
        opacityValue = config.stylix.desktop.opacity;
        alphaInt = builtins.floor (opacityValue * 255);
        toHexDigit = n:
          builtins.elemAt [
            "0"
            "1"
            "2"
            "3"
            "4"
            "5"
            "6"
            "7"
            "8"
            "9"
            "a"
            "b"
            "c"
            "d"
            "e"
            "f"
          ] n;
        high = toHexDigit (alphaInt / 16);
        low = toHexDigit (lib.mod alphaInt 16);
      in high + low;
      description = "Opacity as hex alpha value (00-FF)";
    };

    rounding = lib.mkOption {
      type = lib.types.int;
      default = 12;
      description = "System wide rounding value in pixels";
    };
  };

  config = {
    stylix = {
      enable = true;

      polarity = "dark";
      image = ../../../assets/wallpapers/redhead.png;
      base16Scheme = import ./schemes/material-darker.nix;

      targets = {
        starship.enable = false;
        waybar.enable = false;
      };

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

      cursor = lib.mkIf config.stylix.desktop.enableCursor {
        package = pkgs.capitaine-cursors;
        name = "capitaine-cursors";
        size = 16;
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
