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

      set -g status-position top
      set -g window-status-separator ""
      set -g status-left-length 50

      set -g status-left "#[fg=#${config.lib.stylix.colors.base08},bg=#${config.lib.stylix.colors.base02}] #[fg=#${config.lib.stylix.colors.base05},bg=#${config.lib.stylix.colors.base02}]#S "

      set -g message-style "fg=#${config.lib.stylix.colors.base05},bg=#${config.lib.stylix.colors.base02}"
      set -g message-command-style "fg=#${config.lib.stylix.colors.base05},bg=#${config.lib.stylix.colors.base02}"

      set -g status-style "fg=#${config.lib.stylix.colors.base05},bg=#${config.lib.stylix.colors.base02}"

      set -g window-status-format "#[fg=#${config.lib.stylix.colors.base05},bg=#${config.lib.stylix.colors.base02}] #I  #W "
      set -g window-status-current-format "#[fg=#${config.lib.stylix.colors.base07},bg=#${config.lib.stylix.colors.base0D}] #I  #W "

      set -g status-right-length 100
      set -g status-right "#[fg=#${config.lib.stylix.colors.base0B},bg=#${config.lib.stylix.colors.base02}]  #[fg=#${config.lib.stylix.colors.base05}]#{pane_current_path}"
    '';

    plugins = with pkgs.tmuxPlugins; [
      vim-tmux-navigator
      yank
      resurrect
    ];
  };
}
