{ config, lib, ... }:
let opacity = config.stylix.desktop.opacity;
in {
  options.wezterm.desktop = {
    windowDecorationResize = lib.mkEnableOption "different window decoration"
      // {
        dfault = false;
      };
  };
  config.programs.wezterm = {
    enable = true;
    extraConfig = ''
      local wezterm = require 'wezterm'

      return {
        term = "wezterm",
        default_cursor_style = "SteadyBlock",
        enable_tab_bar = false,
        window_background_opacity = ${toString opacity},
        macos_window_background_blur = 60,
        font = wezterm.font '${config.stylix.fonts.monospace.name}',
        ${
          if config.wezterm.desktop.windowDecorationResize then
            "window_decorations = 'RESIZE',"
          else
            ""
        }
      }
    '';
  };
}
