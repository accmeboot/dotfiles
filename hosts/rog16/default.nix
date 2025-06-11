{ config, pkgs, ... }: {
  imports = [
   ./hardware-configuration.nix
  ];

  #----------------------------------------------------------------------------#
  # NIX SETTINGS                                                               #
  #----------------------------------------------------------------------------#
  nix =  {
    settings = {
      experimental-features = [ "nix-command" "flakes" ];
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 10d";
    };
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
    nvidia = {
      modesetting.enable = true;
      open = true;
      nvidiaSettings = true;

      prime = {
        intelBusId = "PCI:0:2:0";
        nvidiaBusId = "PCI:1:0:0";
      };
    };
    graphics = {
      enable = true;
    };
    logitech.wireless.enable = true;
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
      verbose = false;
    };

    kernelParams = [
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
  system.stateVersion = "25.05";

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
    gnome.gnome-keyring.enable = true;
    blueman.enable = true;
    envfs.enable = true;
    displayManager.gdm.enable = true;

    xserver = {
      videoDrivers = ["nvidia"];
      xkb = {
        layout = "us";
        variant = "";
      };
      desktopManager.gnome.enable = true;
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
    asusd = {
      enable = true;
      enableUserService = true;
    };
    supergfxd.enable = true;
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
