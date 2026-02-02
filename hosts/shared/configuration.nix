{ pkgs, ... }: {
  imports = [ ./packages.nix ];

  #----------------------------------------------------------------------------#
  # NIX SETTINGS                                                               #
  #----------------------------------------------------------------------------#
  nix = {
    settings = { experimental-features = [ "nix-command" "flakes" ]; };
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
  };

  #----------------------------------------------------------------------------#
  # BOOT & KERNEL                                                              #
  #----------------------------------------------------------------------------#
  boot = {
    loader = {
      systemd-boot.enable = true;
      timeout = 0;
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot";
      };
    };

    consoleLogLevel = 3;

    plymouth = { enable = true; };

    initrd = { verbose = false; };

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

  #----------------------------------------------------------------------------#
  # PROGRAMS                                                                   #
  #----------------------------------------------------------------------------#
  programs = {
    nix-ld = { enable = true; };
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
      jack.enable = true;
    };

    # displayManager.cosmic-greeter.enable = true;
    desktopManager.cosmic.enable = true;
    system76-scheduler.enable = true;

    blueman.enable = true;

    envfs.enable = true;
    xserver.xkb = {
      layout = "us,ru";
      variant = "";
      options = "grp:alt_shift_toggle";
    };

    greetd = {
      enable = true;
      settings = {
        default_session = {
          command =
            "${pkgs.tuigreet}/bin/tuigreet --time --remember --remember-session";
          user = "greeter";
        };
      };
    };

    xserver = {
      enable = true;
      exportConfiguration = true;
      displayManager.startx.enable = true;
      monitorSection = ''
        Option "DPMS" "true"
      '';
      autoRepeatDelay = 300;
      autoRepeatInterval = 25;

      displayManager.session = [{
        manage = "desktop";
        name = "dwm";
        start = ''
          if [ -f "$HOME/.xinitrc" ]; then
            exec $HOME/.xinitrc
          elif [ -f "$HOME/.xsession" ]; then
            exec $HOME/.xsession
          fi
        '';
      }];
    };

    picom = {
      enable = true;
      backend = "glx";
      settings = {
        shadow = false;
        fading = false;
        inactive-opacity = 1.0;
        active-opacity = 1.0;
        unredir-if-possible = true;
        glx-no-stencil = true;
        glx-no-rebind-pixmap = true;

        # Blur settings
        blur = {
          method = "dual_kawase";
          strength = 4;
          deviation = 1.0;
        };
        blur-background = true;
        blur-background-frame = false;
        blur-background-fixed = false;

        # Exclude popup/dropdown menus from blur
        blur-background-exclude = [
          "window_type = 'dock'"
          "window_type = 'desktop'"
          "window_type = 'dropdown_menu'"
          "window_type = 'popup_menu'"
          "window_type = 'tooltip'"
          "class_g = 'slop'"
          "_GTK_FRAME_EXTENTS@:c"
        ];
      };
    };

    libinput = {
      enable = true;
      mouse = {
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
            main = { rightcontrol = "rightmeta"; };
            otherlayer = { };
          };
        };
      };
    };
  };

  #----------------------------------------------------------------------------#
  # USERS                                                                #
  #----------------------------------------------------------------------------#

  users.defaultUserShell = pkgs.zsh;

  #----------------------------------------------------------------------------#
  # ENVIRONMENT                                                                #
  #----------------------------------------------------------------------------#
  environment.variables = {
    QT_STYLE_OVERRIDE = "kvantum";
    EDITOR = "nvim";
  };

  environment.sessionVariables = {
    SDL_JOYSTICK_HIDAPI = "0"; # is required for xpadneo

    LUA_PATH =
      "${pkgs.luarocks}/share/lua/5.1/?.lua;${pkgs.luarocks}/share/lua/5.1/?/init.lua;;";
    LUA_CPATH = "${pkgs.luarocks}/lib/lua/5.1/?.so;;";
  };
}
