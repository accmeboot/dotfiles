{ config, lib, pkgs, ... }:
{
  programs.tmux = {
    enable = true;
    shell = "$SHELL"; 
    sensibleOnTop = false;
    keyMode = "vi";
    mouse = true;
    terminal = "tmux-256color";
    aggressiveResize = true;
    extraConfig = ''
      # settings for image preview to work in yazi
      set -g allow-passthrough on

      set -ga update-environment TERM
      set -ga update-environment TERM_PROGRAM

      set -sg escape-time 0

      set -g prefix C-n
      unbind C-b
      bind-key C-n send-prefix

      set -g default-terminal "tmux-256color"
      set -as terminal-features ",xterm-256color:RGB"
      set -as terminal-overrides ',*:Smulx=\E[4::%p1%dm'
      set -as terminal-overrides ',*:Smulc=\E[4::%p1%dm'

      set-option -g focus-events on

      unbind %
      bind | split-window -h

      unbind '"'
      bind - split-window -v

      bind -r j resize-pane -D 5
      bind -r k resize-pane -U 5
      bind -r l resize-pane -R 5
      bind -r h resize-pane -L 5

      bind -r m resize-pane -Z

      set -g mouse on

      set-window-option -g mode-keys vi

      bind-key -T copy-mode-vi 'v' send -X begin-selection
      bind-key -T copy-mode-vi 'y' send -X copy-selection

      unbind -T copy-mode-vi MouseDragEnd1Pane

      bind-key f split-window -v -c "#{pane_current_path}" 'yazi'

      # Start windows and panes index at 1, not 0.
      set -g base-index 1
      setw -g pane-base-index 1

      # Ensure window index numbers get reordered on delete.
      set-option -g renumber-windows on

      set -g status-position top
      set -g window-status-separator " | "
      set -g status-left-length 50

      set -g message-style "fg=#${config.theme.colors.base05},bg=#${config.theme.colors.base00}"
      set -g message-command-style "fg=#${config.theme.colors.base05},bg=#${config.theme.colors.base00}"

      set -g status-style "fg=#${config.theme.colors.base05},bg=#${config.theme.colors.base00}"

      set -g status-left " "

      set -g window-status-format "#[fg=#${config.theme.colors.base05},bg=#${config.theme.colors.base00}]#I:#W"
      set -g window-status-current-format "#[fg=#${config.theme.colors.base0D},bg=#${config.theme.colors.base00}]#I:#W*"

      set -g status-right-length 100
      set -g status-right "#[fg=#${config.theme.colors.base05},bg=#${config.theme.colors.base00}] #{session_path}   #S "
    '';

    plugins = with pkgs.tmuxPlugins; [
      vim-tmux-navigator
      yank
      resurrect
    ];
  };
}
