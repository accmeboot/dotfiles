{ ... }: {
  programs.opencode = {
    enable = true;
    settings = {
      keybinds = {
        leader = "ctrl+x";
        messages_half_page_up = "ctrl+k";
        messages_half_page_down = "ctrl+j";
        input_newline = "shift+enter";
      };
    };
  };
}

