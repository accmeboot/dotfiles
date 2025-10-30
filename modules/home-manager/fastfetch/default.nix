{ ... }:
{
  programs.fastfetch = {
    enable = true;
    settings = {
      "$schema" = "https://github.com/fastfetch-cli/fastfetch/raw/dev/doc/json_schema.json";
      logo = {
          type = "kitty-icat";
          source = ../../../assets/icons/nixos.png;
          width = 20;
          height = 20;
      };
      display.separator = " ";
      modules = [
          {
            key = "╭────────────╮";
            type = "custom";
          }
          {
            key = "│ {#33}󰅐 uptime   {#keys}│";
            type = "uptime";
          }
          {
            key = "│ {#34}{icon} distro   {#keys}│";
            type = "os";
          }
          {
            key = "│ {#35} kernel   {#keys}│";
            type = "kernel";
          }
          {
            key = "│ {#36}󰇄 desktop  {#keys}│";
            type = "de";
          }
          {
            key = "│ {#33}󰏖 packages {#keys}│";
            type = "packages";
          }
          {
            key = "│ {#34}󰉉 disk     {#keys}│";
            type = "disk";
            folders = "/";
          }
          {
            key = "│ {#35} memory   {#keys}│";
            type = "memory";
          }
          {
            key = "├────────────┤";
            type = "custom";
          }
          {
            key = "│ {#39} colors   {#keys}│";
            type = "colors";
            symbol = "circle";
          }
          {
            key = "╰────────────╯";
            type = "custom";
          }
      ];
    };
  };
}
