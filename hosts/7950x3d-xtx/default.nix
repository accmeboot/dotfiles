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
    };
    logitech.wireless.enable = true;
  };

  system.stateVersion = "24.11";

  users = {
    users.accme = {
      isNormalUser = true;
      description = "accme";
      extraGroups = [ "networkmanager" "wheel" ];
    };
  };
}
