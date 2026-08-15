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
    loader = {
      systemd-boot.enable = true;
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot";
      };
    };
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
  };

  #----------------------------------------------------------------------------#
  # XDG PORTAL                                                                 #
  #----------------------------------------------------------------------------#
  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk pkgs.xdg-desktop-portal-wlr ];
    config.common.default = [ "wlr" "gtk" ];
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
  };
}
