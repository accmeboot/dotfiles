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
  };

  #----------------------------------------------------------------------------#
  # BOOT & KERNEL                                                              #
  #----------------------------------------------------------------------------#
  boot = {
    plymouth = {
      enable = true;
      theme = "glow";
    };

    loader = {
      systemd-boot.enable = true;
      timeout = 0;

      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot";
      };
    };

    consoleLogLevel = 3;

    initrd = { verbose = false; };

    kernelParams =
      [ "quiet" "rd.udev.log_level=3" "rd.systemd.show_status=auto" ];
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
    gamescope = {
      enable = true;
      package = pkgs.gamescope.overrideAttrs
        (_: { NIX_CFLAGS_COMPILE = [ "-fno-fast-math" ]; });
    };
    steam = {
      enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
      localNetworkGameTransfers.openFirewall = true;
      gamescopeSession.enable = true;
    };
    gamemode.enable = true;
    dconf.enable = true;
    obs-studio = { enable = true; };
    sway.enable = true;
  };

  #----------------------------------------------------------------------------#
  # XDG PORTAL                                                                 #
  #----------------------------------------------------------------------------#
  xdg.portal = {
    enable = true;
    xdgOpenUsePortal = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];

    wlr.enable = true;
    wlr.settings.screencast = {
      output_name = "";
      chooser_type = "dmenu";
      chooser_cmd = "${pkgs.rofi}/bin/rofi -dmenu -p 'Source:'";
    };
  };

  #----------------------------------------------------------------------------#
  # SECURITY                                                                   #
  #----------------------------------------------------------------------------#
  security = {
    rtkit.enable = true;
    polkit.enable = true;
    pam.services.swaylock = { };
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

    greetd = {
      enable = true;
      settings = {
        default_session = {
          command =
            "${pkgs.tuigreet}/bin/tuigreet --time --cmd sway --remember --remember-user-session";
          user = "greeter";
        };
      };
    };

    envfs.enable = true;

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
  # SYSTEMD                                                                #
  #----------------------------------------------------------------------------#

  systemd.user.services.kanshi = {
    description = "kanshi daemon";
    serviceConfig = {
      Type = "simple";
      ExecStart = "${pkgs.kanshi}/bin/kanshi -c kanshi_config_file";
    };
  };

  #----------------------------------------------------------------------------#
  # ENVIRONMENT                                                                #
  #----------------------------------------------------------------------------#

  environment.variables = { EDITOR = "nvim"; };

  environment.sessionVariables = {
    STEAM_EXTRA_COMPAT_TOOLS_PATHS =
      "\${HOME}/.steam/root/compatibilitytools.d";

    LUA_PATH =
      "${pkgs.luarocks}/share/lua/5.1/?.lua;${pkgs.luarocks}/share/lua/5.1/?/init.lua;;";
    LUA_CPATH = "${pkgs.luarocks}/lib/lua/5.1/?.so;;";

    XDG_CURRENT_DESKTOP = "sway";
  };
}
