{ config, lib, pkgs, ... }:
{
  options.programs.zsh.enableNvm = lib.mkEnableOption "nvm support in zsh";

  config = {
    programs.zsh = {
      enable = true;
      sessionVariables = {
        EDITOR = "nvim";
        VISUAL = "nvim";
      };
      initContent = ''
        bindkey -v
        fastfetch --load-config "$HOME/.config/fastfetch/config.jsonc"

        # Source the .env file
        if [ -f "$HOME/.env" ]; then
          source "$HOME/.env"
        fi

        ${lib.optionalString config.programs.zsh.enableNvm ''
          export NVM_DIR="$HOME/.nvm"
          [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
          [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
        ''}
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
  };
}
