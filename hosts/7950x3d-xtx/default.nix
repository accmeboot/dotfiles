{ config, pkgs, ... }: {
  imports = [
    ../shared/configuration.nix
    ../shared/packages.nix

    ./hardware-configuration.nix
  ];

  hardware = {
    graphics = {
      enable = true;
      enable32Bit = true;
      extraPackages = with pkgs; [
        rocmPackages.clr.icd
      ];
    };
    logitech.wireless.enable = true;
    openrazer = {
      enable = true;
    };
  };

  system.stateVersion = "24.11";

  systemd = {
    tmpfiles.rules = [
      "L+    /opt/rocm/hip   -    -    -     -    ${pkgs.rocmPackages.clr}"
    ];
  };

  users = {
   users.accme = {
     isNormalUser = true;
     description = "accme";
     extraGroups = [ "networkmanager" "wheel" "openrazer" ];
   };
   defaultUserShell = pkgs.zsh;
  };


  services.solaar = { # this is logitech services
    enable = false;
      package = pkgs.solaar;
      window = "hide"; # Show the window on startup (show, *hide*, only [window only])
      batteryIcons = "solaar"; # Which battery icons to use (*regular*, symbolic, solaar)
      extraArgs = ""; # Extra arguments to pass to solaar on startup
  };

  environment.systemPackages = with pkgs; [
    openrazer-daemon
    razer-cli
  ];
}
