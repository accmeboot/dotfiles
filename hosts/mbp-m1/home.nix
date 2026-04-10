{ ... }: {
  home = {
    stateVersion = "24.11";
    username = "Mikhail_Vialov";
    homeDirectory = /Users/Mikhail_Vialov;
  };

  programs.zsh = {
    enableNvm = false;
    enableDirenv = false;
  };

  stylix.desktop = {
    enableCursor = false;
    enableWallpaper = false;
    enableIcons = false;
  };
}
