{ config, ... }:
# TODO: need to monitor ghostty nix package, currently it doesn't allow darwin (macos) as a platform
{
  home.file.".config/ghostty/config".text = ''
    font-family=""
    font-size=11
    background-opacity=${toString config.theme.opacity}
    cursor-style=block
    shell-integration-features=no-cursor
    app-notifications=false
    window-padding-x=${toString config.theme.spacing.m}
    window-padding-y=${toString config.theme.spacing.m}
    window-padding-balance=true
    window-decoration=false

    background=${config.theme.colors.base00}
    foreground=${config.theme.colors.base05}
    cursor-color=${config.theme.colors.base05}
    selection-background=${config.theme.colors.base02}
    selection-foreground=${config.theme.colors.base05}

    palette=0=${config.theme.colors.base00}
    palette=1=${config.theme.colors.base08}
    palette=2=${config.theme.colors.base0B}
    palette=3=${config.theme.colors.base0A}
    palette=4=${config.theme.colors.base0D}
    palette=5=${config.theme.colors.base0E}
    palette=6=${config.theme.colors.base0C}
    palette=7=${config.theme.colors.base05}
    palette=8=${config.theme.colors.base03}
    palette=9=${config.theme.colors.base08}
    palette=10=${config.theme.colors.base0B}
    palette=11=${config.theme.colors.base0A}
    palette=12=${config.theme.colors.base0D}
    palette=13=${config.theme.colors.base0E}
    palette=14=${config.theme.colors.base0C}
    palette=15=${config.theme.colors.base07}
  '';
}
