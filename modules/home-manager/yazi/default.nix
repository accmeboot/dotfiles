{ ... }: {
  programs.yazi = {
    enable = true;
    shellWrapperName = "y";
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
