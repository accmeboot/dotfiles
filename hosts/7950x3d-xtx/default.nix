{ pkgs, ... }: {
  imports = [
    ../../config/system.nix
    ../../config/dev.nix
    ../../config/gaming.nix
    ../../config/desktop.nix
    ../../config/solaar.nix
    ../../config/dwl

    ./hardware-configuration.nix
  ];

  hardware = {
    graphics = {
      enable = true;
      enable32Bit = true;
    };
  };

  system.stateVersion = "24.11";

  users = {
    users.accme = {
      isNormalUser = true;
      description = "accme";
      extraGroups = [
        "networkmanager"
        "wheel"
        "gamemode"
      ];
    };
  };
}
