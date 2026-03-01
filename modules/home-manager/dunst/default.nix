{ config, pkgs, lib, ... }:
let
  colors = config.lib.stylix.colors;
  rounding = config.stylix.desktop.rounding;
  opacityHex = config.stylix.desktop.opacityHex;
in {
  services.dunst = {
    enable = true;
    settings = {
      global = {
        width = "350";
        height = "(0,200)";
        offset = "(24, 24)";
        corner_radius = rounding;
        icon_corner_radius = rounding;
        frame_width = 1;
        frame_color = "#${colors.base03}";
        gap_size = 4;
        max_icon_size = 128;
        dmenu = "${pkgs.rofi}/bin/rofi -p 'Select:' -dmenu";
        min_icon_size = 32;
        text_icon_padding = 8;
        vertical_alignment = "center";
        show_indicators = true;
        mouse_middle_click = "context";
      };
      urgency_low = lib.mkForce {
        background = "#${colors.base01}${opacityHex}";
        foreground = "#${colors.base05}";
      };

      urgency_normal = lib.mkForce {
        background = "#${colors.base01}${opacityHex}";
        foreground = "#${colors.base05}";
      };

      urgency_critical = lib.mkForce {
        background = "#${colors.base08}${opacityHex}";
        foreground = "#${colors.base00}";
      };
    };
  };
}
