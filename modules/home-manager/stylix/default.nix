{ pkgs, inputs, lib, config, ... }:
let
  dark = {
    image = "${../../../assets/wallpapers/cyberpunk_catppuccin.jpg}";
    scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";
    polarity = "dark";
  };

  light = {
    image = "${../../../assets/wallpapers/rocket-launch.jpg}";
    scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-latte.yaml";
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
          package = inputs.apple-fonts.packages.${pkgs.system}.sf-pro-nerd;
          name = "SFProDisplay Nerd Font";
        };
        sansSerif = {
          package = inputs.apple-fonts.packages.${pkgs.system}.sf-pro-nerd;
          name = "SFProDisplay Nerd Font";
        };
        monospace = {
          package = inputs.apple-fonts.packages.${pkgs.system}.sf-pro-nerd;
          name = "SFProDisplay Nerd Font";
        };
        sizes = {
          applications = 11;
          desktop = 11;
          popups = 11;
          terminal = 11;
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
