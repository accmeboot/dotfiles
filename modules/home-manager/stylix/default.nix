{ pkgs, inputs, lib, config, ... }:
let
  # Helper to parse YAML base16 schemes
  parseBase16Scheme = schemeFile:
    let
      yamlContent = builtins.readFile schemeFile;
      # Use yq to convert YAML to JSON, then parse it
      jsonContent = builtins.fromJSON (builtins.readFile
        (pkgs.runCommand "scheme-to-json" { } ''
          ${pkgs.yq-go}/bin/yq eval -o=json ${schemeFile} > $out
        ''));
    in jsonContent.palette or jsonContent;

  colorSchemes = {
    light = "${pkgs.base16-schemes}/share/themes/gruvbox-light-medium.yaml";
    dark = "${pkgs.base16-schemes}/share/themes/gruvbox-dark-medium.yaml";
  };

  # Parse the color schemes into attribute sets
  parsedSchemes = {
    light = parseBase16Scheme colorSchemes.light;
    dark = parseBase16Scheme colorSchemes.dark;
  };
in {

  imports = [ inputs.stylix.homeModules.stylix ];

  options = {
    _colorSchemes = lib.mkOption {
      type = lib.types.attrs;
      default = parsedSchemes;
      description = "Light and dark color schemes for stylix";
    };

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
      autoEnable = false;

      polarity = "dark";

      base16Scheme = colorSchemes.dark;

      targets = {
        gtk.enable = !config.isMacos;
        qt.enable = !config.isMacos;
        fontconfig.enable = !config.isMacos;

        yazi.enable = true;
      };

      fonts = lib.mkIf (!config.isMacos) {
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

      cursor = lib.mkIf (!config.isMacos) {
        package = pkgs.vanilla-dmz;
        name = "Vanilla-DMZ";
        size = 16;
      };

      icons = lib.mkIf (!config.isMacos) {
        enable = true;
        package = pkgs.papirus-icon-theme;
        dark = "Papirus";
        light = "Papirus";
      };
    };
  };
}
