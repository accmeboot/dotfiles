{ config, pkgs, ... }: {
  services.dunst = {
    enable = true;
    iconTheme = {
      name = "Papirus";
      package = pkgs.papirus-icon-theme;
    };

    settings = {
      global = {
        width = "(200,400)";
        offset = config.theme.spacing.xxl;
        corner_radius = config.theme.borderRadius;
        icon_corner_radius = config.theme.borderRadius;
        frame_width = 0;
        gap_size = config.theme.spacing.xs;
        max_icon_size = 128;
        dmenu = "rofi -p 'Select:' -dmenu";
        show_indicators = true;
        mouse_middle_click = "context";
      };
    };
  };
}
