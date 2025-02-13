{ config, pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    vim
    gcc
    kitty
    brave
    neovim 
    git
    rofi
    python3
    nodejs
    go
    rustup
    lua
    fzf
    fastfetch
    starship
    nemo
    yazi
    tmux
    cmake
    gnumake
    bluez
    wlr-randr
    xclip
    pavucontrol
    jq
    fd
    ripgrep
    unzip
    steam
    btop
    htop
    nvtopPackages.full
    lm_sensors
    papirus-icon-theme
    gsettings-desktop-schemas
    glib
    telegram-desktop
    spotify
    discord
    pciutils
    mupdf # media viewer
    mpv # video player

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
