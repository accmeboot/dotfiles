{ config, ... }:
let
  theme = config.stylix.theme;
  icons = config.stylix.icons;
  iconBase = "${config.home.homeDirectory}/.local/share/icons/${icons.dark}";
in {
  services.dunst = {
    enable = true;

    settings = {
      global = {
        width = "350";
        height = "(0,200)";
        offset = theme.spacing.xxl;
        corner_radius = theme.borderRadius;
        icon_corner_radius = theme.borderRadius;
        frame_width = 0;
        gap_size = theme.spacing.xs;
        max_icon_size = 128;
        min_icon_size = 64;
        text_icon_padding = theme.spacing.s;
        vertical_alignment = "center";
        dmenu = "rofi -p 'Select:' -dmenu";
        show_indicators = true;
        mouse_middle_click = "context";

        # Include all relevant icon categories
        icon_path =
          "${iconBase}/16x16/apps/:${iconBase}/16x16/actions/:${iconBase}/16x16/status/:${iconBase}/16x16/devices/:${iconBase}/22x22/apps/:${iconBase}/22x22/actions/:${iconBase}/22x22/status/:${iconBase}/22x22/devices/:${iconBase}/24x24/apps/:${iconBase}/24x24/actions/:${iconBase}/24x24/status/:${iconBase}/24x24/devices/:${iconBase}/32x32/apps/:${iconBase}/32x32/actions/:${iconBase}/32x32/status/:${iconBase}/32x32/devices/:${iconBase}/48x48/apps/:${iconBase}/48x48/actions/:${iconBase}/48x48/status/:${iconBase}/48x48/devices/:${iconBase}/scalable/apps/:${iconBase}/scalable/actions/:${iconBase}/scalable/status/:${iconBase}/scalable/devices/";
      };
    };
  };
}
