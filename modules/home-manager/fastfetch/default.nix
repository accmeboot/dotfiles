{ ... }: {
  programs.fastfetch = {
    enable = true;
    settings = {
      "$schema" =
        "https://github.com/fastfetch-cli/fastfetch/raw/dev/doc/json_schema.json";
      logo = { type = "none"; };
      display.separator = " ";
      modules = [
        {
          key = "╭────────────╮";
          type = "custom";
        }
        {
          key = "│ {#39}󰅐 uptime   {#keys}│";
          type = "uptime";
        }
        {
          key = "│ {#39}{icon} distro   {#keys}│";
          type = "os";
        }
        {
          key = "│ {#39} kernel   {#keys}│";
          type = "kernel";
        }
        {
          key = "│ {#39}󰏖 packages {#keys}│";
          type = "packages";
        }
        {
          key = "│ {#39}󰉉 disk     {#keys}│";
          type = "disk";
          folders = "/";
        }
        {
          key = "│ {#39} memory   {#keys}│";
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
