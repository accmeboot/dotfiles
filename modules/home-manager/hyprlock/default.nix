{ config, pkgs, lib, ... }:
{
  programs.hyprlock = {
    enable = true;
    settings = {
      general = {
        disable_loading_bar = true;
        grace = 5;
        hide_cursor = true;
        no_fade_in = false;
      };

      background = lib.mkForce [
        {
          path = "${config.stylix.image}";
          blur_passes = 3;
          blur_size = 8;
        }
      ];

      input-field = lib.mkForce [
        {
          size = "200, 50";
          position = "0, -80";
          monitor = "";
          dots_center = true;
          fade_on_empty = false;
          font_color = "rgb(${config.lib.stylix.colors.base05})";
          inner_color = "rgb(${config.lib.stylix.colors.base00})";
          outer_color = "rgb(${config.lib.stylix.colors.base01})";
          outline_thickness = 5;
          placeholder_text = "Password...";
          shadow_passes = 2;
        }
      ];

      label = [
        {
          monitor = "";
          text = "$USER";
          color = "rgb(${config.lib.stylix.colors.base05})";
          font_size = 20;
          position = "-100, 160";
          halign = "right";
          valign = "bottom";
          shadow_passes = 5;
          shadow_size = 10;
        }

        {
          monitor = "";
          text = "cmd[update:1000] echo \"$TIME\"";
          color = "rgb(${config.lib.stylix.colors.base05})";
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
