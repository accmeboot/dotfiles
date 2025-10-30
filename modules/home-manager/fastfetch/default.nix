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
            key = "│ {#32}{icon} distro   {#keys}│";
            type = "os";
          }
          {
            key = "│ {#34} kernel   {#keys}│";
            type = "kernel";
          }
          {
            key = "│ {#35}󰏖 packages {#keys}│";
            type = "packages";
          }
          {
            key = "│ {#31}󰉉 disk     {#keys}│";
            type = "disk";
            folders = "/";
          }
          {
            key = "│ {#36} memory   {#keys}│";
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
