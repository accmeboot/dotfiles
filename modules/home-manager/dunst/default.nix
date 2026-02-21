{ config, pkgs, lib, ... }:
let colors = config.lib.stylix.colors;
in {
  services.dunst = {
    enable = true;
    settings = {
      global = {
        width = "350";
        height = "(0,200)";
        offset = "(24, 48)";
        corner_radius = 0;
        icon_corner_radius = 0;
        frame_width = 0;
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
        background = "#${colors.base01}";
        foreground = "#${colors.base05}";
      };

      urgency_normal = lib.mkForce {
        background = "#${colors.base01}";
        foreground = "#${colors.base05}";
      };

      urgency_critical = lib.mkForce {
        background = "#${colors.base08}";
        foreground = "#${colors.base00}";
      };
    };
  };
}
