{ ... }: {
  programs.wezterm = {
    enable = true;
    extraConfig = ''
      local wezterm = require 'wezterm'

      return {
        term = "wezterm",
        default_cursor_style = "SteadyBlock",
        enable_tab_bar = false,
        font = wezterm.font 'JetBrains Mono',
      }
    '';
  };
}
