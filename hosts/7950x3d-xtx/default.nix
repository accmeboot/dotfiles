{ config, pkgs, ... }: {
  imports = [
   ./hardware-configuration.nix
  ];

  #----------------------------------------------------------------------------#
  # NIX SETTINGS                                                               #
  #----------------------------------------------------------------------------#
  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
  };

  #----------------------------------------------------------------------------#
  # HARDWARE CONFIGURATION                                                     #
  #----------------------------------------------------------------------------#
  hardware = {
    bluetooth = {
      enable = true;
      powerOnBoot = true;
    };
    xpadneo.enable = true; # enables support for the Xbox One controller
    graphics = {
      enable = true;
      enable32Bit = true;
      extraPackages = with pkgs; [
        rocmPackages.clr.icd
      ];
    };
  };

  #----------------------------------------------------------------------------#
  # BOOT & KERNEL                                                              #
  #----------------------------------------------------------------------------#
  boot = {
    loader = {
      grub = {
        enable = true;
        device = "nodev";
        efiSupport = true;
        useOSProber = true;
      };
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot";
      };
    };
    initrd.kernelModules = [ "amdgpu" ];
    kernelParams = [ "video=DP-2:1920x1080@360" ];
  };

  #----------------------------------------------------------------------------#
  # NETWORKING                                                                 #
  #----------------------------------------------------------------------------#
  networking = {
    hostName = "nixos";
    networkmanager.enable = true;
  };

  #----------------------------------------------------------------------------#
  # SYSTEM SETTINGS                                                            #
  #----------------------------------------------------------------------------#
  time.timeZone = "Europe/Belgrade";
  i18n.defaultLocale = "en_US.UTF-8";
  nixpkgs.config.allowUnfree = true;
  system.stateVersion = "24.11";

  #----------------------------------------------------------------------------#
  # SYSTEMD SERVICES                                                           #
  #----------------------------------------------------------------------------#
  systemd = {
    # kanshi systemd service
    # we don't run Sway itself as a systemd service.
    # There are auxiliary daemons that we do want to run
    # as systemd services, for example Kanshi
    user.services.kanshi = {
      description = "kanshi daemon";
      environment = {
        WAYLAND_DISPLAY = "wayland-1";
        DISPLAY = ":0";
      };
      serviceConfig = {
        Type = "simple";
        ExecStart = ''${pkgs.kanshi}/bin/kanshi -c kanshi_config_file'';
      };
    };
    tmpfiles.rules = let
      rocmEnv = pkgs.symlinkJoin {
        name = "rocm-combined";
        paths = with pkgs.rocmPackages; [
          rocblas
          hipblas
          clr
        ];
      };
    in [
      "L+    /opt/rocm   -    -    -     -    ${rocmEnv}"
    ];
  };

  #----------------------------------------------------------------------------#
  # PROGRAMS                                                                   #
  #----------------------------------------------------------------------------#
  programs = {
    nix-ld = {
      enable = true;
    };
    sway = {
      enable = true;
      wrapperFeatures.gtk = true;
      extraPackages = with pkgs; [
        swaylock
        swayidle
        swaybg
        wmenu
        foot
      ];
    };
    zsh.enable = true;
    starship.enable = true;
    steam = {
      enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
      localNetworkGameTransfers.openFirewall = true;
      gamescopeSession.enable = true;
    };
    gamemode.enable = true;
    dconf.enable = true;
  };

  #----------------------------------------------------------------------------#
  # SECURITY                                                                   #
  #----------------------------------------------------------------------------#
  security = {
    rtkit.enable = true;
    polkit.enable = true;
    pam.services.swaylock = {};
  };

  #----------------------------------------------------------------------------#
  # SERVICES                                                                   #
  #----------------------------------------------------------------------------#
  services = {
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };
    solaar = {
      enable = true; # Enable the service
      package = pkgs.solaar; # The package to use
      window = "hide"; # Show the window on startup (show, *hide*, only [window only])
      batteryIcons = "solaar"; # Which battery icons to use (*regular*, symbolic, solaar)
      extraArgs = ""; # Extra arguments to pass to solaar on startup
    };
    gnome.gnome-keyring.enable = true;
    blueman.enable = true;
    envfs.enable = true;
    greetd = {
      enable = true;
      settings = {
        default_session = {
          command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --cmd sway";
          user = "greeter";
        };
      };
    };
    xserver.xkb = {
      layout = "us";
      variant = "";
    };
    libinput = {
      enable = true;
      mouse = {
        accelProfile = "flat";
        accelSpeed = "0";
      };
      touchpad = {
        accelProfile = "flat";
        accelSpeed = "0";
      };
    };
    keyd = {
      enable = true;
      keyboards = {
        default = {
          ids = [ "*" ];
          settings = {
            main = {
              rightcontrol = "rightmeta";
            };
            otherlayer = {};
          };
        };
      };
    };
  };

  #----------------------------------------------------------------------------#
  # USERS                                                                      #
  #----------------------------------------------------------------------------#
  users = {
    users.accme = {
      isNormalUser = true;
      description = "accme";
      extraGroups = [ "networkmanager" "wheel" ];
      packages = with pkgs; [];
    };
    defaultUserShell = pkgs.zsh;
  };


  #----------------------------------------------------------------------------#
  # ENVIRONMENT                                                                #
  #----------------------------------------------------------------------------#
  environment.sessionVariables = {
    XCURSOR_PATH = [
      "${pkgs.capitaine-cursors}/share/icons"
    ];
    NIXOS_OZONE_WL = "1";

    XKB_DEFAULT_LAYOUT = "us,ru";
    XKB_DEFAULT_OPTIONS = "grp:ctrl_space_toggle";

    MANGOHUD="1"; # for mangohud

    LUA_PATH = "${pkgs.luarocks}/share/lua/5.1/?.lua;${pkgs.luarocks}/share/lua/5.1/?/init.lua;;";
    LUA_CPATH = "${pkgs.luarocks}/lib/lua/5.1/?.so;;";
  };
}
