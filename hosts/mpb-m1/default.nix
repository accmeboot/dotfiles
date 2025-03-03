{ pkgs, ... }: {
  services.nix-daemon.enable = true;
  
  environment.systemPackages = with pkgs; [
    git
    curl
    wget
  ];

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

      NSGlobalDomain = {
        AppleShowAllExtensions = true;
        InitialKeyRepeat = 15;
        KeyRepeat = 2;
      };
    };
  };
}
