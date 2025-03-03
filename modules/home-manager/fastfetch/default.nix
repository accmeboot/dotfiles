{ config, lib, pkgs, ... }:
{
  programs.fastfetch = {
    enable = true;
    settings = {
      "$schema" = "https://github.com/fastfetch-cli/fastfetch/raw/dev/doc/json_schema.json";
      logo.type = "none";
      general.multithreading = true;
      display.separator = " ";
      modules = [
        "break"
        {
          key = "  󰅐 ";
          keyColor = "yellow";
          type = "uptime";
        }
        {
          key = "   ";
          keyColor = "yellow";
          type = "packages";
        }
        {
          key = "   ";
          keyColor = "yellow";
          type = "wm";
        }
        {
          key = "   ";
          keyColor = "yellow";
          type = "shell";
        }
        {
          key = "   ";
          keyColor = "yellow";
          type = "terminal";
        }
        {
          key = "  󰑭 ";
          keyColor = "yellow";
          type = "memory";
        }
        "break"
      ];
    };
  };
}
