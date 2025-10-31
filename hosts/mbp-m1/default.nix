{ pkgs, ... }: {
  users.users.Mikhail_Vialov = {
    name = "Mikhail_Vialov";
    home = /Users/Mikhail_Vialov;
  };

  system.primaryUser = "Mikhail_Vialov";

  environment.systemPackages = with pkgs; [
    ffmpegthumbnailer
    unar
    jq
    poppler
    fd
    ripgrep
    fzf
    zoxide
    git
    curl
    wget
    rustup
  ];

  homebrew = {
    enable = true;
    brews = [ "borders" ];
    casks = [ "aerospace" ];
    taps = [ "FelixKratz/formulae" "nikitabobko/aerospace" ];
  };

  system = {
    defaults = {
      dock = {
        autohide = true;
        orientation = "bottom";
      };

      finder = {
        AppleShowAllExtensions = true;
        _FXShowPosixPathInTitle = true;
      };
    };
    stateVersion = 5;
  };
}
