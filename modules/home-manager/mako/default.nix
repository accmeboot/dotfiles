{ config, pkgs, lib, ... }:
{
  services.mako = {
    enable = true;
    settings = {
      sort = "-time";
      layer = "overlay";
      border-size = config.theme.borderWidth;
      border-radius = config.theme.borderRadius;
      icons = true;

      width = 400;

      default-timeout = 5000;
      ignore-timeout = true;
      border-color = "#${config.theme.colors.base05}";
      text-color = "#${config.theme.colors.base05}";
      background-color = "${config.theme.hexToHexOpacity config.theme.colors.base00 (config.theme.opacity * 0.5)}";
      progress-color = "${config.theme.hexToHexOpacity config.theme.colors.base03 (config.theme.opacity * 0.5)}";
      font = "MesloLG 9";
      padding = 10;

      icon-border-radius = 32; # the default with and height of the icon is 64

      anchor = "top-right";


      outer-margin = toString config.theme.spacing.xxl;
      margin = 0;

      "app-name=volume" = {
        anchor = "bottom-center";
        outer-margin = "0,0,100";
        width = 300;
        default-timeout = 2000;
        font = "MesloLG 12";
      };
    };
  };
}
