{ config, lib, pkgs, ... }:

{
  programs.zsh = {
    enable = true;
    initExtra = ''
      bindkey -v
      fastfetch --load-config "$HOME/.config/fastfetch/config.jsonc"
    '';

    # Aliases
    shellAliases = {
      nv = "nvim";
      icat = "kitten icat";
    };

    # Use built-in plugin options
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
  };
}

