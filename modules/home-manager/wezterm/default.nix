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
        window_background_opacity = ${toString config.theme.opacity},
        macos_window_background_blur = 60,
        ${
          if config.wezterm.desktop.disableWindowDecoration then
            "window_decorations = 'RESIZE',"
          else
            ""
        }
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
