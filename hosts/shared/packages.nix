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
    brave

    # Programming Languages
    python3 # python programming language
    nodejs # JavaScript runtime environment
    go # go programming language
    rustup # rust toolchain installer
    lua # lua programming language
    luarocks # package manager for Lua modules

    # Terminal Utilities
    fzf # command-line fuzzy finder
    htop # resource monitor
    fd # fast alternative to 'find'
    ripgrep # fast alternative to grep
    jq # command-line JSON processor
    unzip # zip file extraction utility
    ollama # running local llms

    # File Management
    nemo # graphical file manager

    # System Tools
    lm_sensors # hardware monitoring utilities
    pciutils # PCI utilities for device inspection
    bluez # bluetooth protocol stack

    # Wayland Tools
    xclip # command line interface to X clipboard
    wl-clipboard # wayland clipboard utilities

    # Media & Viewers
    mupdf # PDF viewer
    mpv # video player
    gimp # image editor
    mediainfo # cli to view files mediainfo
    playerctl # required by waybar mpris module

    # Screenshot & Recording
    grim # screenshot utility for wayland
    slurp # region selector for wayland
    wl-clipboard # wayland based clipboard command tool

    # Desktop Environment
    wiremix # tui volume control
    easyeffects # pipewire equalizer
    gowall # convert wallpaper to the theme
    cava # audio visualizer

    # Communication & Entertainment
    telegram-desktop # messaging application
    spotify # music streaming service
    discord # chat and voice communication platform
    thunderbird # email client
    transmission_4-gtk # torrent client
    obs-studio # screen recording

    # System Libraries
    gsettings-desktop-schemas # GSettings desktop schemas
    glib # low-level core library for GNOME
    libnotify # notification library
    socat # listen to events on sockets

    # Gaming Platform
    # lutris

    # Network Tools
    networkmanagerapplet # network manager GUI

    libsForQt5.qtstyleplugin-kvantum # qt-theme framework
  ];

  #----------------------------------------------------------------------------#
  # FONTS                                                                       #
  #----------------------------------------------------------------------------#
  fonts.packages =
    builtins.filter pkgs.lib.isDerivation (builtins.attrValues pkgs.nerd-fonts);
}
