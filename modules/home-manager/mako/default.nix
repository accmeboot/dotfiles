{ config, pkgs, lib, ... }:
let
  hexToRgba = hexColor: opacity: 
    let
      # Convert opacity (0.0-1.0) to hex alpha (00-FF)
      opacityToHex = opacity:
        let
          # Convert float to integer (0-255)
          alphaInt = builtins.floor (opacity * 255);
          # Convert to hex
          toHexChar = n: 
            if n < 10 then toString n
            else if n == 10 then "A"
            else if n == 11 then "B"
            else if n == 12 then "C"
            else if n == 13 then "D"
            else if n == 14 then "E"
            else "F";
          high = builtins.floor (alphaInt / 16);
          low = alphaInt - (high * 16);
        in
          toHexChar high + toHexChar low;
    in
      "#${hexColor}${opacityToHex opacity}";
in {
  services.mako = {
    enable = true;
    settings = {
      sort = "-time";
      layer = "overlay";
      border-size = 2;
      border-radius = 8;
      icons = true;

      width = 400;

      default-timeout = 5000;
      ignore-timeout = true;
      border-color = "#${config.lib.stylix.colors.base05}";
      text-color = "#${config.lib.stylix.colors.base05}";
      background-color = "${hexToRgba config.lib.stylix.colors.base00 0.8}";
      progress-color = "${hexToRgba config.lib.stylix.colors.base03 0.8}";
      font = "MesloLG 9";
      padding = 10;

      icon-border-radius = 32;

      anchor = "top-right";


      outer-margin = "4";
      margin = 0;

      "app-name=volume" = {
        anchor = "bottom-center";
        outer-margin = "0,0,100";
        width = 300;
        default-timeout = 2000;
      };
    };
  };
}
