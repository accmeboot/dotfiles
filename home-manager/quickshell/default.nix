{
  config,
  inputs,
  pkgs,
  ...
}:
let
  mesa-shell = inputs.mesa-shell.packages.${pkgs.stdenv.hostPlatform.system}.default;
  json = pkgs.formats.json { };
  dark = config.lib.stylix.colors;
  light = config.specialisation.light.configuration.lib.stylix.colors or config.lib.stylix.colors;
in
{
  programs.quickshell = {
    enable = true;
    activeConfig = "mesa-shell";
    systemd = {
      enable = true;
      target = "dwl-session.target";
    };
  };
  systemd.user.services.quickshell.Unit.PartOf = [ "dwl-session.target" ];

  home.packages = with pkgs; [
    wlr-randr
    bluez
    psmisc
  ];

  xdg.configFile."quickshell/mesa-shell" = {
    source = "${mesa-shell}/share/mesa-shell";
    recursive = true;
  };

  xdg.configFile."quickshell/mesa-shell/config.json".source = json.generate "mesa-shell-config.json" {
    colors = {
      dark = {
        background = "#${dark.base00}";
        surface = "#${dark.base01}";
        on_surface = "#${dark.base02}";
        foreground = "#${dark.base05}";
        highlight = "#${dark.base05}";
        attention = "#${dark.base0A}";
        ok = "#${dark.base0B}";
        critical = "#${dark.base08}";
      };
      light = {
        background = "#${light.base00}";
        surface = "#${light.base01}";
        on_surface = "#${light.base02}";
        foreground = "#${light.base05}";
        highlight = "#${light.base05}";
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
    spacing = 10;
    border = 1;
    wallpaper = "${config.stylix.image}";
  };
}
