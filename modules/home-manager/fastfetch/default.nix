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
          padding = {
            left = 1;
            top = 0;
          };
      };
      general.multithreading = true;
      display.separator = " ";
      modules = [
        "break"
        {
          key = "󰅐 ";
          keyColor = "yellow";
          type = "uptime";
        }
        {
          key = " ";
          keyColor = "yellow";
          type = "packages";
        }
        {
          key = " ";
          keyColor = "yellow";
          type = "wm";
        }
        {
          key = " ";
          keyColor = "yellow";
          type = "shell";
        }
        {
          key = " ";
          keyColor = "yellow";
          type = "terminal";
        }
        {
          key = " ";
          keyColor = "yellow";
          type = "disk";
        }
        {
          key = "󰑭 ";
          keyColor = "yellow";
          type = "memory";
        }
        "break"
        {
          type = "custom";
          format = "{#90}  {#31}  {#32}  {#33}  {#34}  {#35}  {#36}  {#37}  {#38}  {#39} ";
        }
        "break"
      ];
    };
  };
}
