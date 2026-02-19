{ ... }: {
  programs.yazi = {
    enable = true;
    theme = {
      status = {
        sep_left = {
          close = "";
          open = "";
        };
        sep_right = {
          open = "";
          close = "";
        };
      };
      indicator = {
        padding = {
          open = "█";
          close = "█";
        };
      };
    };
    settings = {
      opener = {
        edit = [{
          run = ''nvim "$@"'';
          block = true;
        }];
      };
    };
  };
}
