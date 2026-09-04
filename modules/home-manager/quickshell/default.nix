{ config, pkgs, ... }: {
  programs.quickshell = {
    enable = true;
    activeConfig = "mesa-shell";
    systemd.enable = true;
  };

  home.file.".config/quickshell/mesa-shell/config.json".text = ''

    {
      "colors": {
        "background": "#${config.lib.stylix.colors.base00}",
        "surface": "#${config.lib.stylix.colors.base01}",
        "on_surface": "#${config.lib.stylix.colors.base02}",
        "foreground": "#${config.lib.stylix.colors.base05}",
        "highlight": "#${config.lib.stylix.colors.base0D}",
        "attention": "#${config.lib.stylix.colors.base0A}",
        "ok": "#${config.lib.stylix.colors.base0B}",
        "critical": "#${config.lib.stylix.colors.base08}"
      },
      "font": {
        "name": "${config.stylix.fonts.sansSerif.name}",
        "size": "${toString config.stylix.fonts.sizes.desktop}"
      },
      "spacing": 8,
      "border": 1
    }
  '';

  home.packages = with pkgs; [ qt6.qt5compat ];
}
