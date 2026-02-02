{ ... }: {
  programs.tray-tui = {
    enable = true;
    settings = {
      colors = {
        # background color for menu
        bg = "reset";

        # background color for focused menu
        bg_focused = "reset";

        # foreground color for menu
        fg = "white";

        # foreground color for focused menu
        fg_focused = "white";

        # background color for highlighted item in menu
        bg_highlighted = "blue";

        # foreground color for highlighted item in menu
        fg_highlighted = "black";

        # foreground color for border
        border_fg = "white";

        # foreground color for focused border
        border_fg_focused = "blue";

        # backrgound color for border
        border_bg = "reset";

        # backrgound color for focused border
        border_bg_focused = "reset";
      };
    };
  };
}
