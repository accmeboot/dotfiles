{ config, lib, ... }: {
  options.programs.zsh.enableNvm = lib.mkEnableOption "nvm support in zsh";

  config = {
    programs.zsh = {
      enable = true;
      sessionVariables = {
        EDITOR = "nvim";
        VISUAL = "nvim";
        DIRENV_WARN_TIMEOUT = "60s";
      };
      initContent = ''
        bindkey -v

        # Source the .env file
        if [ -f "$HOME/.env" ]; then
          source "$HOME/.env"
        fi

        ${lib.optionalString config.programs.zsh.enableNvm ''
          export NVM_DIR="$HOME/.nvm"
          [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
          [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
        ''}

        eval "$(direnv hook zsh)"
      '';

      # Aliases
      shellAliases = {
        nv = "nvim";
        icat = "kitten icat";
        fzfnv = "nvim $(fzf)";
        cf = "clear && fastfetch";
        mpv-picker = "${../../../scripts/mpv-select.sh}";
      };

      # Use built-in plugin options
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;
    };
  };
}
