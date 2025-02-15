{ config, pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    vim          # terminal text editor
    gcc          # GNU Compiler Collection
    kitty        # GPU-accelerated terminal emulator
    brave        # privacy-focused web browser
    neovim       # modern vim-based text editor
    git          # version control system
    rofi-wayland # application launcher and window switcher
    python3      # python programming language
    nodejs       # JavaScript runtime environment
    go           # go programming language
    rustup       # rust toolchain installer
    lua          # lua programming language
    fzf          # command-line fuzzy finder
    fastfetch    # system information tool
    starship     # customizable shell prompt
    nemo         # file manager
    yazi         # terminal file manager
    tmux         # terminal multiplexer
    cmake        # cross-platform build system generator
    gnumake      # build automation tool
    bluez        # bluetooth protocol stack
    wlr-randr    # wayland display configuration tool
    xclip        # command line interface to X clipboard
    pavucontrol  # PulseAudio volume control
    jq           # command-line JSON processor
    fd           # fast alternative to 'find'
    ripgrep      # fast alternative to grep
    unzip        # zip file extraction utility
    btop         # resource monitor with graphs
    nvtopPackages.full  # GPU process monitor
    lm_sensors   # hardware monitoring utilities
    gsettings-desktop-schemas  # GSettings desktop schemas
    glib         # low-level core library for GNOME
    telegram-desktop  # messaging application
    spotify      # music streaming service
    discord      # chat and voice communication platform
    pciutils     # PCI utilities for device inspection
    mupdf # media viewer
    mpv # video player
    gimp # image editor

    # sway
    grim # screenshot functionality
    slurp # screenshot functionality
    wl-clipboard # wl-copy and wl-paste for copy/paste from stdin / stdout
    mako # notification system developed by swaywm maintainer

    eww # widget manager for wayland

    mangohud # overlay for games
    goverlay # gui settings for mangohud

    networkmanagerapplet # network manager applet
  ];

  environment.sessionVariables = {
    XCURSOR_PATH = [
      "${pkgs.capitaine-cursors}/share/icons"
    ];
    XCURSOR_SIZE = "16";
    NIXOS_OZONE_WL = "1";

    XKB_DEFAULT_LAYOUT = "us,ru";
    XKB_DEFAULT_OPTIONS = "grp:ctrl_space_toggle";

    MANGOHUD="1"; # for mangohud
  };

  fonts.enableDefaultPackages = true;
  fonts.packages = with pkgs; [ nerdfonts ];
}
