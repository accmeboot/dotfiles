{ config, lib, ... }: {
  options.wezterm.desktop = {
    disableWindowDecoration = lib.mkEnableOption "different window decoration"
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
        font = wezterm.font '${config.stylix.fonts.monospace.name}',
        ${
          if config.wezterm.desktop.disableWindowDecoration then
            "window_decorations = 'RESIZE',"
          else
            ""
        }
      }
    '';
  };
}
