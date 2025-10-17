{ config, lib, pkgs, ... }:

{
  programs.yazi = {
    enable = true;
    settings = {
      opener = {
        edit = [
          { run = "nvim \"$@\""; block = true; }
        ];
      };
    };
  };
}
