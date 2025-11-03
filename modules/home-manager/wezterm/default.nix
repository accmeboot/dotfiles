{ config, lib, ... }: {
  options.wezterm.desktop = {
    disableWindowDecoration = lib.mkEnableOption "different window decoration"
      // {
        dfault = false;
      };
    increasePadding = lib.mkEnableOption "bigger paddings" // {
      default = false;
    };
  };

  config.xdg.configFile."wezterm/tmux-keys.lua".source = ./tmux-keys.lua;

  config.programs.wezterm = {
    enable = true;
    extraConfig = ''
      local wezterm = require 'wezterm'
      local tmux_keys = require 'tmux-keys'

      local config = {}

      if wezterm.config_builder then
        config = wezterm.config_builder()
      end

      -- Apply tmux-style keybindings
      tmux_keys.apply_to_config(config)

      -- Visual settings
      config.window_background_opacity = ${toString config.theme.opacity}
      config.macos_window_background_blur = 60

      ${if config.wezterm.desktop.disableWindowDecoration then
        "config.window_decorations = 'RESIZE'"
      else
        ""}
      config.term = "wezterm"
      config.default_cursor_style = "SteadyBlock"
      config.default_prog = {"zsh"}
      config.font = wezterm.font 'JetBrainsMono Nerd Font'
      config.font_size = 12.0

      config.window_padding = {
        left = ${
          if config.wezterm.desktop.increasePadding then
            toString config.theme.spacing.m
          else
            toString config.theme.spacing.s
        },
        right = ${
          if config.wezterm.desktop.increasePadding then
            toString config.theme.spacing.m
          else
            toString config.theme.spacing.s
        },
        top = ${
          if config.wezterm.desktop.increasePadding then
            toString config.theme.spacing.m
          else
            toString config.theme.spacing.s
        },
        bottom = ${
          if config.wezterm.desktop.increasePadding then
            toString config.theme.spacing.m
          else
            toString config.theme.spacing.s
        },
      }

      return config
    '';
  };
}
