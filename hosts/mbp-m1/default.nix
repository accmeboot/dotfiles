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
    htop
  ];

  homebrew = {
    enable = true;
    casks = [ "aerospace" "wezterm" ];
    taps = [ "nikitabobko/aerospace" ];
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
