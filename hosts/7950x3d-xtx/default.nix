{ pkgs, ... }: {
  imports = [
    ../shared/configuration.nix
    ../shared/packages.nix

    ./hardware-configuration.nix
  ];

  hardware = {
    graphics = {
      enable = true;
      enable32Bit = true;
      extraPackages = with pkgs; [ rocmPackages.clr.icd ];
    };
    logitech.wireless.enable = true;
  };

  services.xserver = {
    videoDrivers = [ "amdgpu" ];
    extraConfig = ''
      Section "OutputClass"
        Identifier "AMDgpu"
        MatchDriver "amdgpu"
        Driver "amdgpu"
        Option "VariableRefresh" "true"
      EndSection
    '';
  };

  system.stateVersion = "24.11";

  systemd = {
    tmpfiles.rules =
      [ "L+    /opt/rocm/hip   -    -    -     -    ${pkgs.rocmPackages.clr}" ];
  };

  users = {
    users.accme = {
      isNormalUser = true;
      description = "accme";
      extraGroups = [ "networkmanager" "wheel" ];
    };
  };

  services.solaar = {
    enable = true;
    package = pkgs.solaar;
    window =
      "hide"; # Show the window on startup (show, *hide*, only [window only])
    batteryIcons =
      "regular"; # Which battery icons to use (*regular*, symbolic, solaar)
    extraArgs = ""; # Extra arguments to pass to solaar on startup
  };
}
