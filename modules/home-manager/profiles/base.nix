{ inputs, ... }: {
  imports = [
    ../nvim/default.nix
    ../yazi/default.nix
    ../starship/default.nix
    ../zsh/default.nix
    ../fastfetch/default.nix
    ../tmux/default.nix
    ../ghostty/default.nix

    inputs.stylix.homeModules.stylix
    ../stylix/default.nix
  ];
}
