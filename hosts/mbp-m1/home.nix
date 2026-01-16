{ ... }: {
  home = {
    stateVersion = "24.11";
    username = "Mikhail_Vialov";
    homeDirectory = /Users/Mikhail_Vialov;
  };

  programs.zsh.enableNvm = true;

  stylix.desktop = {
    enableCursor = false;
    enableWallpaper = false;
    enableFonts = false;
  };

  wezterm.desktop.windowDecorationResize = true;
}
