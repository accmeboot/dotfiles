{ config, pkgs, lib, inputs, ... }: {
  #----------------------------------------------------------------------------#
  # SYSTEM PACKAGES                                                             #
  #----------------------------------------------------------------------------#
  environment.systemPackages = with pkgs; [
    # Core Development Tools
    vim          # terminal text editor
    neovim       # modern vim-based text editor
    gcc          # GNU Compiler Collection
    cmake        # cross-platform build system generator
    gnumake      # build automation tool
    git          # version control system

    # from flakes
    inputs.zen-browser.packages.${pkgs.system}.default
    
    # Programming Languages
    python3      # python programming language
    nodejs       # JavaScript runtime environment
    go           # go programming language
    rustup       # rust toolchain installer
    lua          # lua programming language
    luarocks     # package manager for Lua modules

    # Terminal Utilities
    kitty        # GPU-accelerated terminal emulator
    fzf          # command-line fuzzy finder
    fastfetch    # system information tool
    starship     # customizable shell prompt
    tmux         # terminal multiplexer
    btop         # resource monitor with graphs
    fd           # fast alternative to 'find'
    ripgrep      # fast alternative to grep
    jq           # command-line JSON processor
    unzip        # zip file extraction utility

    # File Management
    nemo         # graphical file manager
    yazi         # terminal file manager

    # System Tools
    nvtopPackages.full  # GPU process monitor
    lm_sensors   # hardware monitoring utilities
    pciutils     # PCI utilities for device inspection
    bluez        # bluetooth protocol stack
    
    # Wayland Tools
    rofi         # application launcher and window switcher
    xclip        # command line interface to X clipboard
    wl-clipboard # wayland clipboard utilities
    
    # Media & Viewers
    mupdf        # PDF viewer
    mpv          # video player
    gimp         # image editor
    mediainfo    # cli to view files mediainfo
    
    # Screenshot & Recording
    grim         # screenshot utility for wayland
    slurp        # region selector for wayland
    
    # Desktop Environment
    pavucontrol  # PulseAudio volume control
    wiremix      # tui volume control
    easyeffects  # pipewire equalizer
    gowall       # convert wallpaper to the theme
    cava         # audio visualizer
    
    # Communication & Entertainment
    telegram-desktop  # messaging application
    spotify      # music streaming service
    discord      # chat and voice communication platform
    thunderbird  # email client
    transmission_4-gtk # torrent client
    obs-studio         # screen recording

    # System Libraries
    gsettings-desktop-schemas  # GSettings desktop schemas
    glib         # low-level core library for GNOME
    libnotify    # notification library
    socat        # listen to events on sockets
    brightnessctl #control brightness

    # Gaming Platform
    (lutris.override {
      extraLibraries = pkgs: [
        wineWowPackages.waylandFull  # Wine with Wayland support
      ];
    })           # gaming platform manager

    # Network Tools
    networkmanagerapplet # network manager GUI

    libsForQt5.qtstyleplugin-kvantum # qt-theme framework
  ];

  #----------------------------------------------------------------------------#
  # FONTS                                                                       #
  #----------------------------------------------------------------------------#
  fonts.packages = builtins.filter pkgs.lib.isDerivation (builtins.attrValues pkgs.nerd-fonts);
}
