{ config, ... }: {
  programs.kitty = {
    enable = true;
    extraConfig = ''
      hide_window_decorations titlebar-only

      allow_remote_control yes

      window_padding_width ${toString config.theme.spacing.s}

      background_opacity ${toString config.theme.opacity}
      background_blur 60

      # BEGIN_KITTY_FONTS
      # Font ligatures settings for Jet Brains Mono Font:
      # https://github.com/JetBrains/JetBrainsMono/wiki/OpenType-features
      font_family      family='JetBrainsMono Nerd Font Mono' style=Light
      bold_font        family='JetBrainsMono Nerd Font Mono' style=Bold
      italic_font      family='JetBrainsMono Nerd Font Mono' style='Light Italic'
      bold_italic_font family='JetBrainsMono Nerd Font Mono' style='Bold Italic'
      # END_KITTY_FONTS

      tab_bar_edge top
      tab_bar_style separator
      tab_separator " "
      tab_title_template " {fmt.fg.red}{bell_symbol}{activity_symbol}{fmt.fg.tab}{tab.last_focused_progress_percent}{index}:{title} "

      tab_bar_min_tabs 0
      tab_bar_margin_width ${toString config.theme.spacing.s}
      tab_bar_margin_height ${toString config.theme.spacing.s} ${
        toString config.theme.spacing.s
      }
      tab_bar_margin_color #${config.theme.colors.base00}
      tab_bar_align left

      active_tab_foreground   #${config.theme.colors.base00}
      active_tab_background   #${config.theme.colors.base0D}
      inactive_tab_foreground #${config.theme.colors.base05}
      inactive_tab_background #${config.theme.colors.base00}

      tab_bar_background #${config.theme.colors.base00}

      enabled_layouts horizontal,vertical

      map ctrl+n>c new_tab_with_cwd

      map ctrl+n>n next_tab
      map ctrl+n>p previous_tab


      map ctrl+n>1 goto_tab 1
      map ctrl+n>2 goto_tab 2
      map ctrl+n>3 goto_tab 3
      map ctrl+n>4 goto_tab 4
      map ctrl+n>5 goto_tab 5

      map ctrl+n>x close_window

      map ctrl+n>r start_resizing_window

      map ctrl+n>h neighboring_window left
      map ctrl+n>l neighboring_window right  
      map ctrl+n>k neighboring_window up
      map ctrl+n>j neighboring_window down


      map ctrl+n>s new_window_with_cwd
      map ctrl+n>m next_layout


      map ctrl+n>slash launch --type=overlay --stdin-source=@screen_scrollback nvim -c "set readonly nomodifiable noswapfile" -c "set buftype=nofile" -
      map ctrl+n>f new_window_with_cwd yazi

      # this is needed for opencode to accept new line with shift+enter
      map shift+enter send_text all \x1b[13;2u
    '';
  };
}
