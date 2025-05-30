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
      grub2-theme = {
        enable = true;
        theme = "vimix";
        footer = true;
      };
    };
    consoleLogLevel = 3;

    plymouth = {
      enable = true;
    };

    initrd = {
      kernelModules = [ "amdgpu" ];
      verbose = false;
    };

    kernelParams = [
      "video=DP-2:1920x1080@360"
      "quiet"
      "splash"
      "boot.shell_on_fail"
      "udev.log_priority=3"
      "rd.systemd.show_status=auto"
    ];
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

    uwsm = {
      enable = true;
      waylandCompositors = {
        hyprland = {
          prettyName = "Hyprland";
          comment = "Hyprland compositor managed by UWSM";
        };
      };
    };

    hyprland = {
      enable = true;
      withUWSM  = true;
    };
  };

  #----------------------------------------------------------------------------#
  # SECURITY                                                                   #
  #----------------------------------------------------------------------------#
  security = {
    rtkit.enable = true;
    polkit.enable = true;
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
      enable = false;
      settings = {
        default_session = {
          command = "${pkgs.greetd.tuigreet}/bin/tuigreet \
                    --time --time-format '%I:%M %p | %a • %h | %F' \
                    --cmd 'uwsm start hyprland'";
          user = "greeter";
        };
      };
    };
    xserver.displayManager.gdm.enable = true;
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
  environment.variables = {
    QT_STYLE_OVERRIDE = "kvantum";
  };

  environment.sessionVariables = {
    XCURSOR_PATH = [
      "${pkgs.capitaine-cursors}/share/icons"
    ];
    NIXOS_OZONE_WL = "1";

    MANGOHUD="1"; # for mangohud

    LUA_PATH = "${pkgs.luarocks}/share/lua/5.1/?.lua;${pkgs.luarocks}/share/lua/5.1/?/init.lua;;";
    LUA_CPATH = "${pkgs.luarocks}/lib/lua/5.1/?.so;;";
  };
}
