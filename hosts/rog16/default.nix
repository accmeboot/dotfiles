{ pkgs, ... }: {
  imports = [
    ../shared/configuration.nix
    ../shared/packages.nix

    ./hardware-configuration.nix
  ];

  hardware = {
    nvidia = {
      modesetting.enable = true;
      open = true;
      nvidiaSettings = true;
      prime = {
        intelBusId = "PCI:0:2:0";
        nvidiaBusId = "PCI:1:0:0";
        offload.enable = true;
      };
    };
    graphics.enable = true;
  };

  services = {
    touchegg.enable = true;
    xserver = { videoDrivers = [ "nvidia" ]; };
    asusd = {
      enable = true;
      enableUserService = true;
    };
    supergfxd.enable = true;
    libinput.touchpad = {
      accelProfile = "adaptive";
      accelSpeed = "0.3";
      naturalScrolling = true;
      clickMethod = "clickfinger";
      disableWhileTyping = true;
      middleEmulation = false;
      scrollMethod = "twofinger";
    };
  };

  environment.systemPackages = with pkgs; [ brightnessctl ];

  users.users.accme = {
    isNormalUser = true;
    description = "accme";
    extraGroups = [ "networkmanager" "wheel" ];
  };

  system.stateVersion = "25.05";
}
