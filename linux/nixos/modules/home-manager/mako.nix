{ config, pkgs, lib, ... }:
{
  services.mako = {
    enable = true;
    sort = "-time";
    layer = "overlay";
    width = 300;
    height = 110;
    borderSize = 2;
    borderRadius = 4;
    icons = true;
    defaultTimeout = 5000;
    ignoreTimeout = true;

    extraConfig = ''
      [app-name="volume"]
      anchor=bottom-center
      outer-margin=0,0,100
      border-radius=4
      progress-color=#${config.lib.stylix.colors.base0A}
      text-color=#${config.lib.stylix.colors.base00}
      background-color=#${config.lib.stylix.colors.base01}
      font=monospace 12
      default-timeout=2000
    '';
  };
}
