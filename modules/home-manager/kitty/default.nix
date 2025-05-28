{ config, lib, pkgs, ... }:

{
  programs.kitty = {
    enable = true;
    extraConfig = ''
      # Base16 Dawn - kitty color config
      # Scheme by accme
      background #${config.lib.stylix.colors.base00}
      foreground #${config.lib.stylix.colors.base05}
      selection_background #${config.lib.stylix.colors.base05}
      selection_foreground #${config.lib.stylix.colors.base00}
      url_color #${config.lib.stylix.colors.base04}
      cursor #${config.lib.stylix.colors.base05}
      cursor_text_color #${config.lib.stylix.colors.base00}
      active_border_color #${config.lib.stylix.colors.base03}
      inactive_border_color #${config.lib.stylix.colors.base01}
      active_tab_background #${config.lib.stylix.colors.base00}
      active_tab_foreground #${config.lib.stylix.colors.base05}
      inactive_tab_background #${config.lib.stylix.colors.base01}
      inactive_tab_foreground #${config.lib.stylix.colors.base04}
      tab_bar_background #${config.lib.stylix.colors.base01}
      wayland_titlebar_color #${config.lib.stylix.colors.base00}
      macos_titlebar_color #${config.lib.stylix.colors.base00}

      # normal
      color0 #${config.lib.stylix.colors.base00}
      color1 #${config.lib.stylix.colors.base08}
      color2 #${config.lib.stylix.colors.base0B}
      color3 #${config.lib.stylix.colors.base0A}
      color4 #${config.lib.stylix.colors.base0D}
      color5 #${config.lib.stylix.colors.base0E}
      color6 #${config.lib.stylix.colors.base0C}
      color7 #${config.lib.stylix.colors.base05}

      # bright
      color8 #${config.lib.stylix.colors.base03}
      color9 #${config.lib.stylix.colors.base09}
      color10 #${config.lib.stylix.colors.base01}
      color11 #${config.lib.stylix.colors.base02}
      color12 #${config.lib.stylix.colors.base04}
      color13 #${config.lib.stylix.colors.base06}
      color14 #${config.lib.stylix.colors.base0F}
      color15 #${config.lib.stylix.colors.base07}

      macos_titlebar_color background
      allow_remote_control yes

      window_padding_width 2

      # BEGIN_KITTY_FONTS
      # Font ligatures settings for Jet Brains Mono Font:
      # https://github.com/JetBrains/JetBrainsMono/wiki/OpenType-features
      font_family      family='JetBrainsMono Nerd Font Mono' style=Light
      bold_font        family='JetBrainsMono Nerd Font Mono' style=Bold
      italic_font      family='JetBrainsMono Nerd Font Mono' style='Light Italic'
      bold_italic_font family='JetBrainsMono Nerd Font Mono' style='Bold Italic'
      # END_KITTY_FONTS


      # BEGIN_KITTY_SYMBOL_MAPS
      symbol_map U+E000-U+F8FF,U+F0000-U+FFFFF,U+100000-U+10ffff JetBrainsMonoNL Nerd Font
      # END_KITTY_SYMBOL_MAPS
    '';
  };
}
