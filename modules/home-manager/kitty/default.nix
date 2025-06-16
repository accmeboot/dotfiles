{ config, lib, pkgs, ... }:

{
  programs.kitty = {
    enable = true;
    extraConfig = ''
      macos_titlebar_color background

      allow_remote_control yes

      window_padding_width 2 4

      cursor_trail 1

      cursor_trail_decay 0.1 0.2

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
