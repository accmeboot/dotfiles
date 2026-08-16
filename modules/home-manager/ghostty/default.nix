{ config, ... }: {
  home.file.".config/ghostty/config".text = ''
    font-family=""
    background-blur=90
    cursor-style=block
    shell-integration-features=no-cursor
    app-notifications=false
    window-padding-x=8
    window-padding-y=8
    window-padding-balance=true

    background=${config.lib.stylix.colors.base00}
    foreground=${config.lib.stylix.colors.base05}
    cursor-color=${config.lib.stylix.colors.base05}
    selection-background=${config.lib.stylix.colors.base02}
    selection-foreground=${config.lib.stylix.colors.base05}

    palette=0=${config.lib.stylix.colors.base00}
    palette=1=${config.lib.stylix.colors.base08}
    palette=2=${config.lib.stylix.colors.base0B}
    palette=3=${config.lib.stylix.colors.base0A}
    palette=4=${config.lib.stylix.colors.base0D}
    palette=5=${config.lib.stylix.colors.base0E}
    palette=6=${config.lib.stylix.colors.base0C}
    palette=7=${config.lib.stylix.colors.base05}
    palette=8=${config.lib.stylix.colors.base03}
    palette=9=${config.lib.stylix.colors.base08}
    palette=10=${config.lib.stylix.colors.base0B}
    palette=11=${config.lib.stylix.colors.base0A}
    palette=12=${config.lib.stylix.colors.base0D}
    palette=13=${config.lib.stylix.colors.base0E}
    palette=14=${config.lib.stylix.colors.base0C}
    palette=15=${config.lib.stylix.colors.base07}
  '';
}

