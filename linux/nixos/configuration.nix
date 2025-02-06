{ config, pkgs, ... }:

let
  home-manager = builtins.fetchTarball {
    url = "https://github.com/nix-community/home-manager/archive/release-24.11.tar.gz";
  };
in
{
  imports = [
    /etc/nixos/hardware-configuration.nix
    (import "${home-manager}/nixos")
    ./modules/system.nix
    ./modules/environment.nix
    ./modules/programs.nix
    ./modules/security.nix
    ./modules/users.nix
    ./modules/home-manager.nix
    ./modules/services.nix
  ];
}
