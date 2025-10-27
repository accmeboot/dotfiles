{ config, ... }:
{
  services.dunst = {
    enable = true;
    settings = {
      global = {
        # Layout and positioning (matching your mako settings)
        width = 400;
        origin = "top-right";
        offset = "${toString config.theme.spacing.xxl}x${toString config.theme.spacing.xxm}";
        gap_size = config.theme.spacing.s;
        
        # Appearance overrides (matching your mako settings) 
        frame_width = 1;  # border-size
        corner_radius = 0;  # border-radius
        padding = 10;
        horizontal_padding = 10;
        
        # Icon settings (matching your mako settings)
        icon_position = "left";  # icons = true
        max_icon_size = 128;  # max-icon-size
        icon_corner_radius = 0;  # icon-border-radius
        
        # Timeout behavior (matching your mako settings)
        idle_threshold = 0;  # ignore-timeout = true equivalent
        
        # Stack behavior (closest to sort = "-time")
        stack_duplicates = true;
        sort = true;  # sort by time
      };

      urgency_normal = {
        timeout = 5;  # default-timeout = 5000ms -> 5s
      };

      urgency_low = {
        timeout = 5;
      };
    };
  };
}
