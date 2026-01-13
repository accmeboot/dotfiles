{ pkgs, lib, config, inputs, ... }: {
  options.stylix.desktop = {
    enableFonts = lib.mkEnableOption "custom fonts" // { default = true; };
    enableCursor = lib.mkEnableOption "cursor theme" // { default = true; };
    enableWallpaper = lib.mkEnableOption "wallpaper" // { default = true; };
  };

  config = {
    stylix = {
      enable = true;

      polarity = "dark";
      image = ../../../assets/wallpapers/sun-mountains.png;
      base16Scheme = import ./schemes/tokyodark.nix;

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
    };
  };
}
