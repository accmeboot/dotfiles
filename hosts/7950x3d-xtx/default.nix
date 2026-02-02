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
    logitech.wireless.enable = false;
    openrazer = { enable = true; };
  };

  services.xserver = {
    videoDrivers = [ "amdgpu" ];
    extraConfig = ''
      Section "OutputClass"
        Identifier "AMDgpu"
        MatchDriver "amdgpu"
        Driver "amdgpu"
        Option "TearFree" "false"
        Option "VariableRefresh" "true"
      EndSection
    '';
  };

  # AMD-specific environment variable
  environment.variables = {
    AMD_VULKAN_ICD = "RADV"; # Use RADV for better FreeSync support
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
      extraGroups = [ "networkmanager" "wheel" "openrazer" ];
    };
  };

  services.solaar = {
    enable = false;
    package = pkgs.solaar;
    window =
      "hide"; # Show the window on startup (show, *hide*, only [window only])
    batteryIcons =
      "symbolic"; # Which battery icons to use (*regular*, symbolic, solaar)
    extraArgs = ""; # Extra arguments to pass to solaar on startup
  };

  environment.systemPackages = with pkgs; [ openrazer-daemon razer-cli ];
}
