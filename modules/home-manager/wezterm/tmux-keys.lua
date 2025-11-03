local wezterm = require 'wezterm'
local act = wezterm.action

local M = {}

-- Tmux-style configuration for WezTerm
-- Replicates the tmux config with Ctrl+n as leader key

function M.apply_to_config(config)
  -- Leader key: Ctrl+n (like tmux prefix)
  config.leader = { key = 'n', mods = 'CTRL', timeout_milliseconds = 1000 }

  -- Start tab numbering at 1 (like tmux base-index)
  config.tab_bar_at_bottom = false
  config.enable_tab_bar = true
  config.hide_tab_bar_if_only_one_tab = true
  config.use_fancy_tab_bar = false
  config.tab_max_width = 32

  -- Add margins around tab bar
  config.window_frame = {
    font = wezterm.font { family = 'JetBrainsMono Nerd Font', weight = 'Bold' },
    font_size = 11.0,
  }

  -- Mouse support (like tmux mouse on)
  config.mouse_bindings = {
    -- Copy selection on mouse release
    {
      event = { Up = { streak = 1, button = 'Left' } },
      mods = 'NONE',
      action = act.CompleteSelection 'ClipboardAndPrimarySelection',
    },
  }

  -- Key bindings
  config.keys = {
    -- Send Ctrl+n to the terminal when pressed twice (like bind-key C-n send-prefix)
    {
      key = 'n',
      mods = 'LEADER|CTRL',
      action = act.SendKey { key = 'n', mods = 'CTRL' },
    },

    -- Split panes (like bind | and bind -)
    {
      key = '|',
      mods = 'LEADER|SHIFT',
      action = act.SplitHorizontal { domain = 'CurrentPaneDomain' },
    },
    {
      key = '-',
      mods = 'LEADER',
      action = act.SplitVertical { domain = 'CurrentPaneDomain' },
    },

    -- Resize panes (like bind -r j/k/l/h resize-pane)
    -- Enter resize mode with leader key, then keep pressing w/a/s/d
    {
      key = 'a',
      mods = 'LEADER',
      action = act.Multiple {
        act.AdjustPaneSize { 'Left', 5 },
        act.ActivateKeyTable {
          name = 'resize_pane',
          timeout_milliseconds = 1000,
        },
      },
    },
    {
      key = 's',
      mods = 'LEADER',
      action = act.Multiple {
        act.AdjustPaneSize { 'Down', 5 },
        act.ActivateKeyTable {
          name = 'resize_pane',
          timeout_milliseconds = 1000,
        },
      },
    },
    {
      key = 'w',
      mods = 'LEADER',
      action = act.Multiple {
        act.AdjustPaneSize { 'Up', 5 },
        act.ActivateKeyTable {
          name = 'resize_pane',
          timeout_milliseconds = 1000,
        },
      },
    },
    {
      key = 'd',
      mods = 'LEADER',
      action = act.Multiple {
        act.AdjustPaneSize { 'Right', 5 },
        act.ActivateKeyTable {
          name = 'resize_pane',
          timeout_milliseconds = 1000,
        },
      },
    },

    -- Zoom/maximize pane (like bind -r m resize-pane -Z)
    {
      key = 'm',
      mods = 'LEADER',
      action = act.TogglePaneZoomState,
    },

    -- Open yazi in a vertical split (like bind-key f)
    {
      key = 'f',
      mods = 'LEADER',
      action = act.SplitVertical {
        args = { 'yazi' },
      },
    },

    -- Open opencode in a horizontal split (like bind-key o)
    {
      key = 'o',
      mods = 'LEADER',
      action = act.SplitHorizontal {
        args = { 'opencode' },
      },
    },

    -- Navigate between panes (vim-tmux-navigator style)
    {
      key = 'h',
      mods = 'LEADER',
      action = act.ActivatePaneDirection 'Left',
    },
    {
      key = 'j',
      mods = 'LEADER',
      action = act.ActivatePaneDirection 'Down',
    },
    {
      key = 'k',
      mods = 'LEADER',
      action = act.ActivatePaneDirection 'Up',
    },
    {
      key = 'l',
      mods = 'LEADER',
      action = act.ActivatePaneDirection 'Right',
    },

    -- Create new tab (like tmux new-window)
    {
      key = 'c',
      mods = 'LEADER',
      action = act.SpawnTab 'CurrentPaneDomain',
    },

    -- Close current pane (like tmux kill-pane)
    {
      key = 'x',
      mods = 'LEADER',
      action = act.CloseCurrentPane { confirm = true },
    },

    -- Navigate tabs (like tmux next-window/previous-window)
    {
      key = 'n',
      mods = 'LEADER',
      action = act.ActivateTabRelative(1),
    },
    {
      key = 'p',
      mods = 'LEADER',
      action = act.ActivateTabRelative(-1),
    },

    -- Switch to specific tab by number (like tmux select-window)
    {
      key = '1',
      mods = 'LEADER',
      action = act.ActivateTab(0),
    },
    {
      key = '2',
      mods = 'LEADER',
      action = act.ActivateTab(1),
    },
    {
      key = '3',
      mods = 'LEADER',
      action = act.ActivateTab(2),
    },
    {
      key = '4',
      mods = 'LEADER',
      action = act.ActivateTab(3),
    },
    {
      key = '5',
      mods = 'LEADER',
      action = act.ActivateTab(4),
    },
    {
      key = '6',
      mods = 'LEADER',
      action = act.ActivateTab(5),
    },
    {
      key = '7',
      mods = 'LEADER',
      action = act.ActivateTab(6),
    },
    {
      key = '8',
      mods = 'LEADER',
      action = act.ActivateTab(7),
    },
    {
      key = '9',
      mods = 'LEADER',
      action = act.ActivateTab(8),
    },

    -- Copy mode (like tmux copy-mode-vi)
    {
      key = '[',
      mods = 'LEADER',
      action = act.ActivateCopyMode,
    },

    -- Rename tab (like tmux rename-window)
    {
      key = ',',
      mods = 'LEADER',
      action = act.PromptInputLine {
        description = 'Enter new name for tab',
        action = wezterm.action_callback(function(window, _, line)
          if line then
            window:active_tab():set_title(line)
          end
        end),
      },
    },
  }

  -- Copy mode key table (vi-style like tmux)
  config.key_tables = {
    -- Resize pane mode - allows repeating w/a/s/d without leader key
    resize_pane = {
      {
        key = 'a',
        action = act.Multiple {
          act.AdjustPaneSize { 'Left', 5 },
          act.ActivateKeyTable {
            name = 'resize_pane',
            timeout_milliseconds = 1000,
          },
        },
      },
      {
        key = 's',
        action = act.Multiple {
          act.AdjustPaneSize { 'Down', 5 },
          act.ActivateKeyTable {
            name = 'resize_pane',
            timeout_milliseconds = 1000,
          },
        },
      },
      {
        key = 'w',
        action = act.Multiple {
          act.AdjustPaneSize { 'Up', 5 },
          act.ActivateKeyTable {
            name = 'resize_pane',
            timeout_milliseconds = 1000,
          },
        },
      },
      {
        key = 'd',
        action = act.Multiple {
          act.AdjustPaneSize { 'Right', 5 },
          act.ActivateKeyTable {
            name = 'resize_pane',
            timeout_milliseconds = 1000,
          },
        },
      },
      -- Exit resize mode with Escape
      {
        key = 'Escape',
        action = 'PopKeyTable',
      },
    },
    copy_mode = {
      -- Navigation (vi-style)
      {
        key = 'h',
        mods = 'NONE',
        action = act.CopyMode 'MoveLeft',
      },
      {
        key = 'j',
        mods = 'NONE',
        action = act.CopyMode 'MoveDown',
      },
      {
        key = 'k',
        mods = 'NONE',
        action = act.CopyMode 'MoveUp',
      },
      {
        key = 'l',
        mods = 'NONE',
        action = act.CopyMode 'MoveRight',
      },
      -- Word navigation
      {
        key = 'w',
        mods = 'NONE',
        action = act.CopyMode 'MoveForwardWord',
      },
      {
        key = 'b',
        mods = 'NONE',
        action = act.CopyMode 'MoveBackwardWord',
      },
      {
        key = 'e',
        mods = 'NONE',
        action = act.CopyMode 'MoveForwardWordEnd',
      },
      -- Line navigation
      {
        key = '0',
        mods = 'NONE',
        action = act.CopyMode 'MoveToStartOfLine',
      },
      {
        key = '^',
        mods = 'NONE',
        action = act.CopyMode 'MoveToStartOfLineContent',
      },
      {
        key = '$',
        mods = 'NONE',
        action = act.CopyMode 'MoveToEndOfLineContent',
      },
      -- Page navigation
      {
        key = 'g',
        mods = 'NONE',
        action = act.CopyMode 'MoveToScrollbackTop',
      },
      {
        key = 'G',
        mods = 'NONE',
        action = act.CopyMode 'MoveToScrollbackBottom',
      },
      {
        key = 'u',
        mods = 'CTRL',
        action = act.CopyMode 'PageUp',
      },
      {
        key = 'd',
        mods = 'CTRL',
        action = act.CopyMode 'PageDown',
      },
      -- Selection (like bind-key -T copy-mode-vi 'v' send -X begin-selection)
      {
        key = 'v',
        mods = 'NONE',
        action = act.CopyMode { SetSelectionMode = 'Cell' },
      },
      {
        key = 'V',
        mods = 'NONE',
        action = act.CopyMode { SetSelectionMode = 'Line' },
      },
      {
        key = 'v',
        mods = 'CTRL',
        action = act.CopyMode { SetSelectionMode = 'Block' },
      },
      -- Copy selection (like bind-key -T copy-mode-vi 'y' send -X copy-selection)
      {
        key = 'y',
        mods = 'NONE',
        action = act.Multiple {
          { CopyTo = 'ClipboardAndPrimarySelection' },
          { CopyMode = 'Close' },
        },
      },
      -- Exit copy mode
      {
        key = 'Escape',
        mods = 'NONE',
        action = act.CopyMode 'Close',
      },
      {
        key = 'q',
        mods = 'NONE',
        action = act.CopyMode 'Close',
      },
      {
        key = 'c',
        mods = 'CTRL',
        action = act.CopyMode 'Close',
      },
    },
  }
end

return M
