{ config, lib, ... }: {
  config = {
    programs.zsh = {
      enable = true;
      sessionVariables = {
        EDITOR = "nvim";
        VISUAL = "nvim";
      };
      initContent = ''
        bindkey -v

        ${lib.optionalString config.isMacos ''
          # pnpm
          export PNPM_HOME="$HOME/Library/pnpm"
          case ":$PATH:" in
            *":$PNPM_HOME/bin:"*) ;;
            *) export PATH="$PNPM_HOME/bin:$PATH" ;;
          esac
          # pnpm end
          export PATH="$HOME/.local/bin:$PATH"
          eval "$(/opt/homebrew/bin/brew shellenv)"
          eval "$(fnm env --shell zsh)"
        ''}

        # Source the .env file
        if [ -f "$HOME/.env" ]; then
          source "$HOME/.env"
        fi

        fastfetch
      '';

      # Aliases
      shellAliases = {
        nv = "nvim";
        icat = "kitten icat";
        fzfnv = "nvim $(fzf)";
        cf = "clear && fastfetch";
        mpv-picker = "${../../scripts/mpv-select.sh}";
      };

      # Use built-in plugin options
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;
    };
  };
}
