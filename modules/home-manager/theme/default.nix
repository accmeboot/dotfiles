{ lib, config, ... }:
let
 hexToHexOpacity = hexColor: opacity:
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

  hexToRgba = hexColor: opacity: 
    let
      hexToDecimal = hex: 
        let
          chars = builtins.listToAttrs [
            { name = "0"; value = 0; } { name = "1"; value = 1; } { name = "2"; value = 2; } { name = "3"; value = 3; }
            { name = "4"; value = 4; } { name = "5"; value = 5; } { name = "6"; value = 6; } { name = "7"; value = 7; }
            { name = "8"; value = 8; } { name = "9"; value = 9; } { name = "a"; value = 10; } { name = "b"; value = 11; }
            { name = "c"; value = 12; } { name = "d"; value = 13; } { name = "e"; value = 14; } { name = "f"; value = 15; }
            { name = "A"; value = 10; } { name = "B"; value = 11; } { name = "C"; value = 12; } { name = "D"; value = 13; }
            { name = "E"; value = 14; } { name = "F"; value = 15; }
          ];
          char1 = builtins.substring 0 1 hex;
          char2 = builtins.substring 1 1 hex;
        in
          chars.${char1} * 16 + chars.${char2};
      
      r = hexToDecimal (builtins.substring 0 2 hexColor);
      g = hexToDecimal (builtins.substring 2 2 hexColor);
      b = hexToDecimal (builtins.substring 4 2 hexColor);
    in
      "rgba(${toString r}, ${toString g}, ${toString b}, ${toString opacity})";
in
{
  options.theme = {
    borderRadius = lib.mkOption {
      type = lib.types.int;
      default = 8;
    };
    borderWidth = lib.mkOption {
      type = lib.types.int;
      default = 2;
    };
    opacity = lib.mkOption {
      type = lib.types.float;
      default = 0.8;

    };
    spacing = lib.mkOption {
      type = lib.types.submodule {
        options = {
          xs = lib.mkOption {
            type = lib.types.int;
            default = 4;
          };
          s = lib.mkOption {
            type = lib.types.int;
            default = 8;
          };
          m = lib.mkOption {
            type = lib.types.int;
            default = 12;
          };
          xxl = lib.mkOption {
            type = lib.types.int;
            default = 24;
          };
        };
      };
      default = {};
    };
    hexToRgba = lib.mkOption {
      type = lib.types.raw;
      default = hexToRgba;
      internal = true;
    };

    hexToHexOpacity = lib.mkOption {
      type = lib.types.raw;
      default = hexToHexOpacity;
      internal = true;
    };
    
    # default scheme is gruvbox
    colors = lib.mkOption {
      type = lib.types.submodule {
        options = {
          base00 = lib.mkOption { type = lib.types.str; default = "282828"; }; # bg
          base01 = lib.mkOption { type = lib.types.str; default = "3c3836"; }; # bg1
          base02 = lib.mkOption { type = lib.types.str; default = "504945"; }; # bg2
          base03 = lib.mkOption { type = lib.types.str; default = "665c54"; }; # bg3
          base04 = lib.mkOption { type = lib.types.str; default = "bdae93"; }; # fg2
          base05 = lib.mkOption { type = lib.types.str; default = "d5c4a1"; }; # fg1
          base06 = lib.mkOption { type = lib.types.str; default = "ebdbb2"; }; # fg0
          base07 = lib.mkOption { type = lib.types.str; default = "fbf1c7"; }; # fg
          base08 = lib.mkOption { type = lib.types.str; default = "fb4934"; }; # red
          base09 = lib.mkOption { type = lib.types.str; default = "fe8019"; }; # orange
          base0A = lib.mkOption { type = lib.types.str; default = "fabd2f"; }; # yellow
          base0B = lib.mkOption { type = lib.types.str; default = "b8bb26"; }; # green
          base0C = lib.mkOption { type = lib.types.str; default = "8ec07c"; }; # aqua
          base0D = lib.mkOption { type = lib.types.str; default = "83a598"; }; # blue
          base0E = lib.mkOption { type = lib.types.str; default = "d3869b"; }; # purple
          base0F = lib.mkOption { type = lib.types.str; default = "d65d0e"; }; # brown
        };
      };
      default = {};
    };
  };

  # Set colors from stylix if available, otherwise use defaults
  config.theme.colors = lib.mkIf (config.stylix.enable or false) {
    base00 = config.stylix.base16Scheme.base00;
    base01 = config.stylix.base16Scheme.base01;
    base02 = config.stylix.base16Scheme.base02;
    base03 = config.stylix.base16Scheme.base03;
    base04 = config.stylix.base16Scheme.base04;
    base05 = config.stylix.base16Scheme.base05;
    base06 = config.stylix.base16Scheme.base06;
    base07 = config.stylix.base16Scheme.base07;
    base08 = config.stylix.base16Scheme.base08;
    base09 = config.stylix.base16Scheme.base09;
    base0A = config.stylix.base16Scheme.base0A;
    base0B = config.stylix.base16Scheme.base0B;
    base0C = config.stylix.base16Scheme.base0C;
    base0D = config.stylix.base16Scheme.base0D;
    base0E = config.stylix.base16Scheme.base0E;
    base0F = config.stylix.base16Scheme.base0F;
  };
}
