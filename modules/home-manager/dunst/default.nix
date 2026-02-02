{ config, pkgs, ... }:
let
  icons = config.stylix.icons;
  colors = config.lib.stylix.colors;
  font = config.stylix.fonts.serif.name;

  dunstDmenu = pkgs.writeShellScriptBin "dunst-dmenu" ''
    exec ${pkgs.dmenu}/bin/dmenu \
      -nb "#${colors.base00}" \
      -fn "${font}:size=12" \
      -nf "#${colors.base05}" \
      -sb "#${colors.base0D}" \
      -sf "#${colors.base00}" \
      -p "dunst:" \
      "$@"
  '';
in {
  services.dunst = {
    enable = true;
    iconTheme = {
      name = icons.dark;
      package = icons.package;
    };

    settings = {
      global = {
        width = "350";
        height = "(0,200)";
        offset = "(24, 48)";
        corner_radius = 4;
        icon_corner_radius = 4;
        frame_width = 0;
        gap_size = 4;
        max_icon_size = 128;
        dmenu = "${dunstDmenu}/bin/dunst-dmenu";
        min_icon_size = 32;
        text_icon_padding = 8;
        vertical_alignment = "center";
        show_indicators = true;
        mouse_middle_click = "context";
      };
    };
  };
}
