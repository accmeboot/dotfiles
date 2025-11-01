{ config, ... }: {
  programs.wezterm = {
    enable = true;
    extraConfig = ''
      local wezterm = require 'wezterm'

      return {
        window_background_opacity = ${toString config.theme.opacity},
        default_cursor_style = "SteadyBlock",
        default_prog = {"zsh"},
        font = wezterm.font 'JetBrainsMono Nerd Font',
        font_size = 12.0,
        enable_tab_bar = false,
        window_padding = {
          left = ${toString config.theme.spacing.s},
          right = ${toString config.theme.spacing.s},
          top = ${toString config.theme.spacing.s},
          bottom = ${toString config.theme.spacing.s},
        },
      }
    '';
  };
}
