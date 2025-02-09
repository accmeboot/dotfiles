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
    lm_sensors
    papirus-icon-theme
    gsettings-desktop-schemas
    glib
    telegram-desktop
    spotify
    discord
    pciutils
    radeontop
    feh # image viewer
    mpv # video player

    # sway
    grim # screenshot functionality
    slurp # screenshot functionality
    wl-clipboard # wl-copy and wl-paste for copy/paste from stdin / stdout
    mako # notification system developed by swaywm maintainer

    eww # widget manager for wayland
  ];

  environment.sessionVariables = {
    XCURSOR_PATH = [
      "${pkgs.capitaine-cursors}/share/icons"
    ];
    XCURSOR_SIZE = "16";
    NIXOS_OZONE_WL = "1";
  };

  fonts.enableDefaultPackages = true;
  fonts.packages = with pkgs; [ nerdfonts ];
}
