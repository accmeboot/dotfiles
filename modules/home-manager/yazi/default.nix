{ lib, ... }: {
  programs.yazi = {
    enable = true;
    shellWrapperName = "y";
    settings = {
      opener = {
        edit = [
          {
            run = ''nvim "$@"'';
            block = true;
          }
        ];
      };
    };
    theme = {
      icon.dirs = lib.mkForce [ ];
      indicator.padding = {
        open = "█";
        close = "█";
      };
      status = {
        sep_left = {
          open = "";
          close = "";
        };
        sep_right = {
          open = "";
          close = "";
        };
      };
    };
  };
}
