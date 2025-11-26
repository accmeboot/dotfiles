{ config, ... }:
let
  theme = config.stylix.theme;
  icons = config.stylix.icons;
in {
  services.dunst = {
    enable = true;
    iconTheme = {
      name = icons.dark;
      package = icons.package;
    };

    settings = {
      global = {
        width = "(200,400)";
        offset = theme.spacing.xxl;
        corner_radius = theme.borderRadius;
        icon_corner_radius = theme.borderRadius;
        frame_width = 0;
        gap_size = theme.spacing.xs;
        max_icon_size = 128;
        dmenu = "rofi -p 'Select:' -dmenu";
        show_indicators = true;
        mouse_middle_click = "context";
      };
    };
  };
}
