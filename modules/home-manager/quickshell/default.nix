{ config, pkgs, ... }: {
  programs.quickshell = {
    enable = true;
    systemd.enable = true;
  };

  home.file.".config/quickshell/settings.json".text = ''
    {
      "colors": {
        "base00": "#${config.lib.stylix.colors.base00}",
        "base01": "#${config.lib.stylix.colors.base01}",
        "base02": "#${config.lib.stylix.colors.base02}",
        "base03": "#${config.lib.stylix.colors.base03}",
        "base04": "#${config.lib.stylix.colors.base04}",
        "base05": "#${config.lib.stylix.colors.base05}",
        "base06": "#${config.lib.stylix.colors.base06}",
        "base07": "#${config.lib.stylix.colors.base07}",
        "base08": "#${config.lib.stylix.colors.base08}",
        "base09": "#${config.lib.stylix.colors.base09}",
        "base0A": "#${config.lib.stylix.colors.base0A}",
        "base0B": "#${config.lib.stylix.colors.base0B}",
        "base0C": "#${config.lib.stylix.colors.base0C}",
        "base0D": "#${config.lib.stylix.colors.base0D}",
        "base0E": "#${config.lib.stylix.colors.base0E}",
        "base0F": "#${config.lib.stylix.colors.base0F}"
      },
      "font": {
        "name": "${config.stylix.fonts.sansSerif.name}",
        "size": "${toString config.stylix.fonts.sizes.desktop}"
      },
      "workspaces": {
        "persistent": true
      },
      "spacing": {
        "horizontal": 20,
        "vertical": 5
      }
    }
  '';

  home.packages = with pkgs; [ qt6.qt5compat ];
}
