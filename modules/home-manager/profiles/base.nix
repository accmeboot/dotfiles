{ inputs, ... }: {
  imports = [
    ../theme/default.nix
    ../nvim/default.nix
    ../yazi/default.nix
    ../starship/default.nix
    ../zsh/default.nix
    ../fastfetch/default.nix
    ../opencode/default.nix
    ../ghostty/default.nix
    ../tmux/default.nix

    inputs.stylix.homeModules.stylix
    ../stylix/default.nix
  ];
}
