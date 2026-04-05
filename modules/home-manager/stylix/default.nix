{ pkgs, lib, config, ... }:

let utils = import ./utils.nix { inherit pkgs lib; };
in {
  options.stylix.desktop = {
    enableFonts = lib.mkEnableOption "custom fonts" // { default = true; };
    enableCursor = lib.mkEnableOption "cursor theme" // { default = true; };
    enableWallpaper = lib.mkEnableOption "wallpaper" // { default = true; };
    enableIcons = lib.mkEnableOption "icon theme" // { default = true; };

    opacity = lib.mkOption {
      type = lib.types.float;
      default = 0.5;
      description = "System wide opacity value";
    };

    opacityHex = lib.mkOption {
      type = lib.types.str;
      readOnly = true;
      default = utils.opacityToHex config.stylix.desktop.opacity;
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

      image = ../../../assets/wallpapers/thefinals.jpg;
      base16Scheme =
        utils.generateMatugenScheme config.stylix.image config.stylix.polarity;

      targets = {
        starship.enable = false;
        waybar.enable = false;
      };

      fonts = lib.mkIf config.stylix.desktop.enableFonts {
        serif = { name = "Arimo Nerd Font"; };
        sansSerif = { name = "Arimo Nerd Font"; };
        monospace = { name = "JetBrainsMono Nerd Font"; };
        sizes = {
          applications = 10;
          desktop = 10;
          popups = 12;
          terminal = 12;
        };
      };

      cursor = lib.mkIf config.stylix.desktop.enableCursor {
        package = pkgs.vanilla-dmz;
        name = "Vanilla-DMZ";
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
