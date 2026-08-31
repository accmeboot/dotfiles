{ pkgs, inputs, lib, config, ... }:
let
  darkScheme = {
    image = "${../../../assets/wallpapers/sway.png}";
    scheme = "${pkgs.base16-schemes}/share/themes/material-darker.yaml";
    polarity = "dark";
  };
  lightScheme = {
    image = "${../../../assets/wallpapers/sway.png}";
    scheme = "${pkgs.base16-schemes}/share/themes/classic-light.yaml";
    polarity = "light";
  };
in {

  imports = [ inputs.stylix.homeModules.stylix ./polarity-toggle.nix ];

  options = {
    isMacos = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description =
        "Whether running on macOS to disable Linux-specific theming";
    };
  };

  config = {

    stylix = {
      enable = true;

      polarity = lib.mkDefault darkScheme.polarity;
      base16Scheme = lib.mkDefault darkScheme.scheme;
      image = lib.mkDefault darkScheme.image;

      targets = {
        sway.enable = false;
        swaylock.enable = false;
        bemenu.enable = false;
        starship.enable = false;
      };

      fonts = lib.mkIf (!config.isMacos) {
        serif = { name = "Arimo Nerd Font"; };
        sansSerif = { name = "Arimo Nerd Font"; };
        monospace = { name = "JetBrainsMono Nerd Font"; };
        sizes = {
          applications = 10;
          desktop = 12;
          popups = 12;
          terminal = 12;
        };
      };

      cursor = lib.mkIf (!config.isMacos) {
        package = pkgs.vanilla-dmz;
        name = "Vanilla-DMZ";
        size = 16;
      };

      icons = lib.mkIf (!config.isMacos) {
        enable = true;
        package = pkgs.papirus-icon-theme;
        dark = "Papirus-Dark";
        light = "Papirus-Light";
      };
    };

    specialisation.light.configuration = {
      stylix = {
        image = lightScheme.image;
        base16Scheme = lightScheme.scheme;
        polarity = lightScheme.polarity;
      };
    };
  };
}
