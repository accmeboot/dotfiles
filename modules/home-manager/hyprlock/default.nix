{ config, lib, ... }: {
  programs.hyprlock = {
    enable = true;
    settings = {
      general = {
        grace = 5;
        hide_cursor = true;
      };

      animations = { enabled = false; };

      background = lib.mkForce [{ path = config.stylix.image; }];

      input-field = lib.mkForce [{
        size = "200, 50";
        position = "0, -80";
        monitor = "";
        dots_center = true;
        fade_on_empty = false;
        font_color = "rgb(${config.theme.colors.base05})";
        inner_color = "rgb(${config.theme.colors.base00})";
        outer_color = "rgb(${config.theme.colors.base0D})";
        outline_thickness = config.theme.borderWidth;
        rounding = config.theme.borderRadius;
        placeholder_text = "Password...";
        shadow_passes = 0;
        shadow_size = 4;
        shadow_boost = 3;
      }];

      label = [
        {
          monitor = "";
          text = "$USER";
          color = "rgb(${config.theme.colors.base05})";
          font_size = 20;
          position = "-100, 160";
          halign = "right";
          valign = "bottom";
          shadow_passes = 5;
          shadow_size = 10;
        }

        {
          monitor = "";
          text = ''cmd[update:1000] echo "$TIME"'';
          color = "rgb(${config.theme.colors.base05})";
          font_size = 55;
          position = "-100, 70";
          halign = "right";
          valign = "bottom";
          shadow_passes = 5;
          shadow_size = 10;
        }
      ];
    };
  };
}
