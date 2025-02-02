# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running 'nixos-help').

{ config, pkgs,  ... }:

let
  home-manager = builtins.fetchTarball {
    url = "https://github.com/nix-community/home-manager/archive/release-24.11.tar.gz";
  };
in
{
  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
  };

  imports =
    [ # Include the results of the hardware scan.
      /etc/nixos/hardware-configuration.nix
      (import "${home-manager}/nixos")
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  services.displayManager.sddm = {
    wayland.enable = true;
    enable = true;
    theme = "catppuccin-mocha";
    package = pkgs.kdePackages.sddm;
    settings = {
      Autologin = {
        Session = "hyprland.desktop";  # Set the regular Hyprland session as default
      };
      General = {
        DisplayServer = "wayland";
        InputMethod = "";
      };
    };
  };

  networking.hostName = "nixos"; # Define your hostname.
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Belgrade";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Define a user account. Don't forget to set a password with 'passwd'.
  users.users.accme = {
    isNormalUser = true;
    description = "accme";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [];
  };

  users.defaultUserShell = pkgs.zsh;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile
  environment.systemPackages = with pkgs; [
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    gcc
    kitty
    brave
    neovim
    git
    rofi
    waybar
    python3
    nodejs
    go
    rustup
    fzf
    fastfetch
    starship
    hyprpaper 
    hyprlock 
    nemo
    yazi
    tmux
    cmake
    gnumake
    bluez 
    blueman 
    wl-clipboard 
    wlr-randr
    xclip 
    grim 
    slurp 
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
    (catppuccin-sddm.override {
     flavor = "mocha";
     font = "Noto Sans";
     fontSize = "9";
     background = "${../../assets/wallpapers/ferris_wheel.jpg}";
     loginBackground = true;
    })
  ];

  fonts.enableDefaultPackages = true;
  fonts.packages = with pkgs; [ nerdfonts ];

  programs = {
    hyprland = {
      enable = true;
      xwayland.enable = true;
    };
    zsh.enable = true;
    starship.enable = true;
    steam.enable = true;
  };

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users.accme = { pkgs, ... }: {
      gtk = {
        enable = true;
        theme = {
          name = "Dracula";
          package = pkgs.dracula-theme;
        };
        iconTheme = {
          name = "Papirus-Dark";
          package = pkgs.papirus-icon-theme;
        };
        cursorTheme = {
          name = "capitaine-cursors";
          package = pkgs.capitaine-cursors;
          size = 16;
        };
        gtk3 = {
          extraConfig.gtk-application-prefer-dark-theme = true;
        };
      };

      home.stateVersion = "24.11";
    };
    backupFileExtension = "backup";
  };

  system.stateVersion = "24.11";
  
  security = {
    polkit.enable = true;
    pam.services.hyprlock = {};
    pam.services.sddm = {};
  };
}
