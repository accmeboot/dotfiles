{ pkgs, ... }: {
  programs.neovim.enable = true;

  programs.neovim.withRuby = false;
  programs.neovim.withPython3 = false;

  home.file = {
    ".config/nvim" = {
      source = ./src;
      recursive = true;
    };
  };

  home.packages = with pkgs; [ tree-sitter file ];
}
