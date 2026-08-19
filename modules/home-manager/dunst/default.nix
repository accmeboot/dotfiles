{ config, pkgs, lib, ... }:
let colors = config.lib.stylix.colors;
in {
  services.dunst = {
    enable = true;
    settings = {
      global = {
        width = "350";
        height = "(0,200)";
        offset = "(24, 24)";
        corner_radius = 0;
        icon_corner_radius = 100;
        frame_width = 1;
        gap_size = 4;
        max_icon_size = 128;
        dmenu = "${pkgs.bemenu}/bin/bemenu -p 'Select:'";
        min_icon_size = 32;
        text_icon_padding = 8;
        vertical_alignment = "center";
        show_indicators = true;
        mouse_middle_click = "context";
        foreground = "#${colors.base05}";
        background = "#${colors.base00}";
      };
      urgency_low = lib.mkForce { frame_color = "#${colors.base05}"; };

      urgency_normal = lib.mkForce { frame_color = "#${colors.base05}"; };

      urgency_critical = lib.mkForce { frame_color = "#${colors.base08}"; };
    };
  };
}
