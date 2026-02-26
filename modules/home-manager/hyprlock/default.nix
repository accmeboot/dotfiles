{ config, lib, ... }:
let colors = config.lib.stylix.colors;
in {
  programs.hyprlock = {
    enable = true;
    settings = {
      general = {
        grace = 5;
        hide_cursor = true;
      };

      animations = { enabled = false; };

      background = lib.mkForce [{
        path = config.stylix.image;
        blur_size = 16;
        blur_passes = 4;
      }];

      input-field = lib.mkForce [{
        size = "200, 50";
        position = "0, -80";
        monitor = "";
        dots_center = true;
        fade_on_empty = false;
        font_color = "rgb(${colors.base05})";
        inner_color = "rgb(${colors.base00})";
        outer_color = "rgb(${colors.base0D})";
        outline_thickness = 1;
        rounding = 12;
        placeholder_text = "Password...";
        shadow_passes = 0;
        shadow_size = 4;
        shadow_boost = 3;
      }];

      label = [
        {
          monitor = "";
          text = "$USER";
          color = "rgb(${colors.base05})";
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
          color = "rgb(${colors.base05})";
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
