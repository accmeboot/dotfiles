{ pkgs, ... }: {
  #----------------------------------------------------------------------------#
  # SYSTEM PACKAGES                                                             #
  #----------------------------------------------------------------------------#
  environment.systemPackages = with pkgs; [
    # Core Development Tools
    vim # terminal text editor
    gcc # GNU Compiler Collection
    cmake # cross-platform build system generator
    gnumake # build automation tool
    git # version control system
    nil # nix language server

    # Programming Languages
    python3 # python programming language
    nodejs # JavaScript runtime environment
    go # go programming language
    rustup # rust toolchain installer
    lua # lua programming language
    luarocks # package manager for Lua modules

    # Terminal Utilities
    fzf # command-line fuzzy finder
    btop # resource monitor
    fd # fast alternative to 'find'
    ripgrep # fast alternative to grep
    jq # command-line JSON processor
    unzip # zip file extraction utility
    ollama # running local llms

    # Media & Viewers
    mpv # video player
    vlc # video player
    gimp # image editor
    brave # browser

    # Communication & Entertainment
    telegram-desktop # messaging application
    spotify # music streaming service
    discord # chat and voice communication platform
    thunderbird # email client
    transmission_4-gtk # torrent client
    obs-studio # screen recording

    # Gnome dependencies
    gsettings-desktop-schemas # GSettings desktop schemas
  ];

  #----------------------------------------------------------------------------#
  # FONTS                                                                       #
  #----------------------------------------------------------------------------#
  fonts.packages =
    builtins.filter pkgs.lib.isDerivation (builtins.attrValues pkgs.nerd-fonts);
}
