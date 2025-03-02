{ config, lib, pkgs, ... }:

{
  programs.yazi = {
    enable = true;
    settings = {
      manager = {
        show_hidden = true;
      };
      opener = {
        edit = [
          { run = "nvim \"$@\""; block = true; }
        ];
      };
    };
  };
}
