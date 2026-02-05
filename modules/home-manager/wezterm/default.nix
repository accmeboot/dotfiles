{ config, lib, ... }: {
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

      local config = {
        term = "wezterm",
        default_cursor_style = "SteadyBlock",
        enable_tab_bar = false,
        window_background_opacity = 0.95,
        macos_window_background_blur = 60,
        font = wezterm.font '${config.stylix.fonts.monospace.name}',
        ${
          if config.wezterm.desktop.windowDecorationResize then
            "window_decorations = 'RESIZE',"
          else
            ""
        }
      }

      -- Check for SystemMenuFloat class via environment variable
      local class = os.getenv('WEZTERM_CLASS')
      if class == 'SystemMenuFloat' then
        config.initial_cols = 90
        config.initial_rows = 30
      end

      return config
    '';
  };
}
