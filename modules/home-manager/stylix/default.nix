{ pkgs, lib, config, ... }:
let
  dark = {
    image = "${../../../assets/wallpapers/horizon-dark.png}";
    scheme = import ../theme/horizon-dark.nix;
    polarity = "dark";
  };

  light = {
    image = "${../../../assets/wallpapers/horizon-light.png}";
    scheme = import ../theme/horizon-light.nix;
    polarity = "light";
  };
in {
  options.stylix.desktop = {
    enableFonts = lib.mkEnableOption "custom fonts" // { default = true; };
    enableIcons = lib.mkEnableOption "icon theme" // { default = true; };
    enableCursor = lib.mkEnableOption "cursor theme" // { default = true; };
    enableWallpaper = lib.mkEnableOption "wallpaper" // { default = true; };
  };

  config = {
    stylix = {
      enable = true;

      polarity = lib.mkDefault dark.polarity;
      image = lib.mkIf config.stylix.desktop.enableWallpaper
        (lib.mkDefault dark.image);
      base16Scheme = lib.mkDefault dark.scheme;

      targets = {
        starship.enable = false;
        waybar.enable = false;
        mako.enable = false;
      };

      fonts = lib.mkIf config.stylix.desktop.enableFonts {
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
          applications = 10;
          desktop = 10;
          popups = 10;
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

    specialisation.light.configuration = {
      stylix = {
        image = light.image;
        base16Scheme = light.scheme;
        polarity = light.polarity;
      };
    };

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
            pkill waybar && setsid waybar > /dev/null 2>&1 &
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
            pkill waybar && setsid waybar > /dev/null 2>&1 &
          else
            echo "Something went terrible wrong ACHTUNG!"
            exit 1
          fi
        '';
      }))
    ];
  };
}
