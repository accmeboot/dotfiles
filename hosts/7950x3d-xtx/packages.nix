{ config, pkgs, ... }: {
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
    
    # Programming Languages
    python3      # python programming language
    nodejs       # JavaScript runtime environment
    go           # go programming language
    rustup       # rust toolchain installer
    lua          # lua programming language

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
    rofi-wayland # application launcher and window switcher
    wlr-randr    # wayland display configuration tool
    xclip        # command line interface to X clipboard
    wl-clipboard # wayland clipboard utilities
    
    # Media & Viewers
    mupdf        # PDF viewer
    mpv          # video player
    gimp         # image editor
    
    # Screenshot & Recording
    grim         # screenshot utility for wayland
    slurp        # region selector for wayland
    
    # Desktop Environment
    eww          # widget system for wayland
    mako         # notification daemon for wayland
    pavucontrol  # PulseAudio volume control
    
    # Gaming
    mangohud     # performance overlay for games
    goverlay     # GUI for mangohud configuration
    
    # Communication & Entertainment
    telegram-desktop  # messaging application
    spotify      # music streaming service
    discord      # chat and voice communication platform
    thunderbird  # email client
    transmission_4-gtk # torrent client

    # System Libraries
    gsettings-desktop-schemas  # GSettings desktop schemas
    glib         # low-level core library for GNOME
    libnotify    # notification library

    # Gaming Platform
    (lutris.override {
      extraLibraries = pkgs: [
        wineWowPackages.waylandFull  # Wine with Wayland support
      ];
    })           # gaming platform manager

    # Network Tools
    networkmanagerapplet # network manager GUI
  ];

  #----------------------------------------------------------------------------#
  # FONTS                                                                       #
  #----------------------------------------------------------------------------#
  fonts.enableDefaultPackages = true;
  fonts.packages = with pkgs; [ nerdfonts ];
}
