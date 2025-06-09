{ config, lib, pkgs, ... }:
{
  programs.fastfetch = {
    enable = true;
    settings = {
      "$schema" = "https://github.com/fastfetch-cli/fastfetch/raw/dev/doc/json_schema.json";
      logo = {
          type = "kitty-icat";
          source = ../../../assets/wallpapers/nix-logo-gruvbox.png;
          width = 22;
          height = 22;
      };
      general.multithreading = true;
      display.separator = " ";
      modules = [
        "break"
        {
          key = "󰅐 ";
         keyColor = "37";
          type = "uptime";
        }
        {
          key = " ";
          keyColor = "31";
          type = "packages";
        }
        {
          key = " ";
          keyColor = "32";
          type = "wm";
        }
        {
          key = " ";
          keyColor = "33";
          type = "shell";
        }
        {
          key = " ";
          keyColor = "34";
          type = "terminal";
        }
        {
          key = " ";
          keyColor = "35";
          type = "disk";
        }
        {
          key = "󰑭 ";
          keyColor = "36";
          type = "memory";
        }
        "break"
        {
          type = "custom";
          format = "{#90}  {#31}  {#32}  {#33}  {#34}  {#35}  {#36}  {#37} ";
        }
        "break"
      ];
    };
  };
}
