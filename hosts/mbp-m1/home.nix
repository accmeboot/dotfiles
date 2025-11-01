{ ... }: {
  home = {
    stateVersion = "24.11";
    username = "Mikhail_Vialov";
    homeDirectory = /Users/Mikhail_Vialov;
  };

  programs.zsh.enableNvm = true;

  stylix.desktop = {
    enableFonts = false;
    enableIcons = false;
    enableCursor = false;
    enableWallpaper = false;
  };

  wezterm.desktop.disableWindowDecoration = true;
}
