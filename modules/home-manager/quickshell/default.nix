{ config, inputs, ... }:
let
  dark = config.lib.stylix.colors;
  light = config.specialisation.light.configuration.lib.stylix.colors or config.lib.stylix.colors;
in
{
  imports = [ inputs.mesa-shell.homeManagerModules.default ];

  programs.quickshell.systemd = {
    enable = true;
    target = "sway-session.target";
  };

  programs.mesa-shell = {
    enable = true;
    settings = {
      colors = {
        dark = {
          background = "#${dark.base00}";
          surface = "#${dark.base01}";
          on_surface = "#${dark.base02}";
          foreground = "#${dark.base05}";
          highlight = "#${dark.base0D}";
          attention = "#${dark.base0A}";
          ok = "#${dark.base0B}";
          critical = "#${dark.base08}";
        };
        light = {
          background = "#${light.base00}";
          surface = "#${light.base01}";
          on_surface = "#${light.base02}";
          foreground = "#${light.base05}";
          highlight = "#${light.base0D}";
          attention = "#${light.base0A}";
          ok = "#${light.base0B}";
          critical = "#${light.base08}";
        };
      };
      defaultPolarity = config.stylix.polarity;
      hooks = {
        onDarkThemeSet = "set-dark-theme";
        onLightThemeSet = "set-light-theme";
      };
      font = {
        name = config.stylix.fonts.sansSerif.name;
        size = config.stylix.fonts.sizes.desktop;
      };
      spacing = 8;
      border = 1;
      wallpaper = "${config.stylix.image}";
    };
  };
}
