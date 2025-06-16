{ lib, config, ... }:
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
      default = 0.9;

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
    base00 = config.lib.stylix.colors.base00;
    base01 = config.lib.stylix.colors.base01;
    base02 = config.lib.stylix.colors.base02;
    base03 = config.lib.stylix.colors.base03;
    base04 = config.lib.stylix.colors.base04;
    base05 = config.lib.stylix.colors.base05;
    base06 = config.lib.stylix.colors.base06;
    base07 = config.lib.stylix.colors.base07;
    base08 = config.lib.stylix.colors.base08;
    base09 = config.lib.stylix.colors.base09;
    base0A = config.lib.stylix.colors.base0A;
    base0B = config.lib.stylix.colors.base0B;
    base0C = config.lib.stylix.colors.base0C;
    base0D = config.lib.stylix.colors.base0D;
    base0E = config.lib.stylix.colors.base0E;
    base0F = config.lib.stylix.colors.base0F;
  };
}
