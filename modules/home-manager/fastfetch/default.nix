{ ... }: {
  programs.fastfetch = {
    enable = true;
    settings = {
      "$schema" =
        "https://github.com/fastfetch-cli/fastfetch/raw/dev/doc/json_schema.json";
      logo = { type = "none"; };
      display = {
        separator = "  ";
        color = { keys = "yellow"; };
        size = {
          ndigits = 0;
          maxPrefix = "MB";
        };
        key = { type = "icon"; };
      };
      modules = [
        {
          type = "title";
          color = {
            user = "green";
            at = "red";
            host = "blue";
          };
        }
        "break"
        "os"
        "kernel"
        "memory"
        "packages"
        "uptime"
        "break"
        {
          type = "colors";
          key = "Colors";
          block = { range = [ 1 6 ]; };
        }
      ];
    };
  };
}
