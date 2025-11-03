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

      config.colors = {
        tab_bar = {
          -- The color of the strip that goes along the top of the window
          -- (does not apply when fancy tab bar is in use)
          background = '#${config.theme.colors.base00}',

          -- The active tab is the one that has focus in the window
          active_tab = {
            -- The color of the background area for the tab
            bg_color = '#${config.theme.colors.base0D}',
            -- The color of the text for the tab
            fg_color = '#${config.theme.colors.base00}',

            -- Specify whether you want "Half", "Normal" or "Bold" intensity for the
            -- label shown for this tab.
            -- The default is "Normal"
            intensity = 'Normal',

            -- Specify whether you want "None", "Single" or "Double" underline for
            -- label shown for this tab.
            -- The default is "None"
            underline = 'None',

            -- Specify whether you want the text to be italic (true) or not (false)
            -- for this tab.  The default is false.
            italic = false,

            -- Specify whether you want the text to be rendered with strikethrough (true)
            -- or not for this tab.  The default is false.
            strikethrough = false,
          },

          -- Inactive tabs are the tabs that do not have focus
          inactive_tab = {
            bg_color = '#${config.theme.colors.base02}',
            fg_color = '#${config.theme.colors.base05}',

            -- The same options that were listed under the `active_tab` section above
            -- can also be used for `inactive_tab`.
          },

          -- You can configure some alternate styling when the mouse pointer
          -- moves over inactive tabs
          inactive_tab_hover = {
            bg_color = '#${config.theme.colors.base03}',
            fg_color = '#${config.theme.colors.base05}',
            italic = false,

            -- The same options that were listed under the `active_tab` section above
            -- can also be used for `inactive_tab_hover`.
          },

          -- The new tab button that let you create new tabs
          new_tab = {
            bg_color = '#${config.theme.colors.base01}',
            fg_color = '#${config.theme.colors.base05}',

            -- The same options that were listed under the `active_tab` section above
            -- can also be used for `new_tab`.
          },

          -- You can configure some alternate styling when the mouse pointer
          -- moves over the new tab button
          new_tab_hover = {
            bg_color = '#${config.theme.colors.base03}',
            fg_color = '#${config.theme.colors.base05}',
            italic = false,

            -- The same options that were listed under the `active_tab` section above
            -- can also be used for `new_tab_hover`.
          },
        },
      }

      return config
    '';
  };
}
