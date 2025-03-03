{ config, lib, pkgs, ... }:

{
  home.file = {
    ".config/MangoHud/MangoHud.conf".source = builtins.path {
      path = ./src/MangoHud.conf;
      name = "MangoHud.conf";
    };
  };
}
