{ config, pkgs, lib, ... }:
{
  services.mako = {
    enable = true;
    settings = {
      sort = "-time";
      layer = "overlay";
      width = 300;
      height = 110;
      border-size = 2;
      border-radius = 4;
      icons = true;
      default-timeout = 5000;
      ignore-timeout = true;
      border-color = lib.mkForce "#${config.lib.stylix.colors.base05}";
      text-color = lib.mkForce "#${config.lib.stylix.colors.base05}";

      "app-name=volume" = {
        anchor = "bottom-center";
        outer-margin = "0,0,100";
        border-radius = 4;
        progress-color = "#${config.lib.stylix.colors.base02}";
        text-color = "#${config.lib.stylix.colors.base0A}";
        background-color = "#${config.lib.stylix.colors.base01}";
        font = "monospace 12";
        default-timeout = 2000;
      };
    };
  };
}
