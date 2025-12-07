{ pkgs, ... }: {
  programs.quickshell.enable = true;
  home.packages = with pkgs; [ kdePackages.qt5compat ];
}
