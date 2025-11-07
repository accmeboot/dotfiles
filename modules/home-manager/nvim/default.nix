{ pkgs, ... }: {
  programs.neovim.enable = true;

  imports = [ ./colorscheme.nix ];

  home.file = {
    ".config/nvim" = {
      source = ./src;
      recursive = true;
    };
  };

  home.packages = with pkgs; [ tree-sitter ];
}
