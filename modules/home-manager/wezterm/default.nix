{ config, ... }: {
  programs.wezterm = {
    enable = true;
    extraConfig = ''
      local wezterm = require 'wezterm'

      return {
        term = "wezterm",
        default_cursor_style = "SteadyBlock",
        enable_tab_bar = false,
        window_decorations = 'RESIZE',
        font = wezterm.font '${config.stylix.fonts.monospace.name}',
      }
    '';
  };
}
