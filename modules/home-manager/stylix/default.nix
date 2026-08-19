{ pkgs, inputs, lib, config, ... }:
let
  theme = import ../../../theme.nix { inherit pkgs lib; };
  darkScheme = theme.darkScheme;
  lightScheme = theme.lightScheme;
in {

  imports = [ inputs.stylix.homeModules.stylix ];

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
        dark = "Papirus-Dark";
        light = "Papirus-Light";
      };
    };

    # this generates separate generation that we can activate manualy
    specialisation.light.configuration = {
      stylix = {
        image = lightScheme.image;
        base16Scheme = lightScheme.scheme;
        polarity = lightScheme.polarity;
      };
    };

    # Base script
    home.packages = [
      (lib.lowPrio (pkgs.writeShellApplication {
        name = "set-light-theme";
        runtimeInputs = with pkgs; [ coreutils nix ];
        text = ''
          current_gen=$(nix-store --query --requisites /run/current-system | grep "home-manager-generation$" | while read -r gen; do
            if [[ -d "$gen/specialisation/light" ]]; then
              echo "$gen"
              break
            fi
          done)

          if [[ -n "$current_gen" ]]; then
            echo "Switching to light theme: $current_gen/specialisation/light"
            "$current_gen"/specialisation/light/activate
          else
            echo "No home-manager generation with light specialisation found"
            exit 1
          fi
        '';
      }))

      (lib.lowPrio (pkgs.writeShellApplication {
        name = "set-dark-theme";
        runtimeInputs = with pkgs; [ coreutils nix ];
        text = ''
          current_gen=$(nix-store --query --requisites /run/current-system | grep "home-manager-generation$" | while read -r gen; do
            if [[ -d "$gen/specialisation/light" ]]; then
              echo "$gen"
              break
            fi
          done)

          if [[ -n "$current_gen" ]]; then
            echo "Switching to dark theme: $current_gen"
            "$current_gen"/activate
          else
            echo "Something went terrible wrong ACHTUNG!"
            exit 1
          fi
        '';
      }))
    ];
  };
}
