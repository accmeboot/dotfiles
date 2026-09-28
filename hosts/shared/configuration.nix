{
  pkgs,
  lib,
  inputs,
  ...
}:
{
  imports = [ ./packages.nix ];

  #----------------------------------------------------------------------------#
  # NIX SETTINGS                                                               #
  #----------------------------------------------------------------------------#
  nix = {
    settings = {
      experimental-features = [
        "nix-command"
        "flakes"
      ];
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
  };

  #----------------------------------------------------------------------------#
  # BOOT & KERNEL                                                              #
  #----------------------------------------------------------------------------#
  boot = {
    plymouth.enable = true;
    loader = {
      systemd-boot.enable = true;
      timeout = 0;

      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot";
      };
    };

    consoleLogLevel = 3;

    initrd = {
      verbose = false;
    };

    kernelParams = [
      "quiet"
      "rd.udev.log_level=3"
      "rd.systemd.show_status=auto"
      "splash"
    ];
  };

  # Don't pivot into /run/initramfs for the final shutdown stage.
  systemd.shutdownRamfs.enable = false;

  #----------------------------------------------------------------------------#
  # NETWORKING                                                               #
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
    nix-ld = {
      enable = true;
    };
    zsh.enable = true;
    starship.enable = true;
    gamescope = {
      enable = true;
      package = pkgs.gamescope.overrideAttrs (_: {
        NIX_CFLAGS_COMPILE = [ "-fno-fast-math" ];
      });
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
    obs-studio = {
      enable = true;
    };
    xwayland.enable = true;
  };

  #----------------------------------------------------------------------------#
  # XDG PORTAL                                                                 #
  #----------------------------------------------------------------------------#
  xdg.portal = {
    enable = true;
    xdgOpenUsePortal = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];

    config.dwl.default = [
      "wlr"
      "gtk"
    ];

    wlr.enable = true;
    wlr.settings.screencast = {
      output_name = "";
      chooser_type = "dmenu";
      chooser_cmd = lib.getExe inputs.mesa-shell.packages.${pkgs.stdenv.hostPlatform.system}.mesa-dmenu;
    };
  };

  #----------------------------------------------------------------------------#
  # DWL SESSION                                                                #
  #----------------------------------------------------------------------------#
  # dwl itself is built in home-manager (for stylix colors), so the session
  # launches it from the per-user profile.
  services.displayManager.sessionPackages =
    let
      dwlSession = pkgs.writeShellScript "dwl-session" ''
        export XDG_CURRENT_DESKTOP=dwl
        export XDG_SESSION_DESKTOP=dwl
        export XDG_SESSION_TYPE=wayland

        # WAYLAND_DISPLAY only exists once dwl is running, so the environment
        # is exported and the target started from dwl's startup command.
        /etc/profiles/per-user/$USER/bin/dwl -s '
          ${pkgs.dbus}/bin/dbus-update-activation-environment --systemd \
            DISPLAY WAYLAND_DISPLAY XDG_CURRENT_DESKTOP XDG_SESSION_DESKTOP XDG_SESSION_TYPE
          systemctl --user start dwl-session.target
        '

        systemctl --user stop dwl-session.target
      '';
    in
    [
      (
        (pkgs.writeTextDir "share/wayland-sessions/dwl.desktop" ''
          [Desktop Entry]
          Name=dwl
          Comment=Dynamic window manager for Wayland
          Exec=${dwlSession}
          Type=Application
        '').overrideAttrs
        { passthru.providedSessions = [ "dwl" ]; }
      )
    ];

  # Normally enabled by a compositor's NixOS module; dwl has none.
  services.graphical-desktop.enable = true;
  services.xserver.desktopManager.runXdgAutostartIfNone = true;

  systemd.user.targets.dwl-session = {
    description = "dwl compositor session";
    documentation = [ "man:systemd.special(7)" ];
    bindsTo = [ "graphical-session.target" ];
    wants = [ "graphical-session-pre.target" ];
    after = [ "graphical-session-pre.target" ];
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

    displayManager.ly.enable = true;

    envfs.enable = true;

    keyd = {
      enable = true;
      keyboards = {
        default = {
          ids = [ "*" ];
          settings = {
            main = {
              rightcontrol = "rightmeta";
            };
            otherlayer = { };
          };
        };
      };
    };

    upower.enable = true;
  };

  #----------------------------------------------------------------------------#
  # USERS                                                                #
  #----------------------------------------------------------------------------#

  users.defaultUserShell = pkgs.zsh;

  #----------------------------------------------------------------------------#
  # ENVIRONMENT                                                                #
  #----------------------------------------------------------------------------#

  environment.variables = {
    EDITOR = "nvim";
  };

  environment.sessionVariables = {
    STEAM_EXTRA_COMPAT_TOOLS_PATHS = "\${HOME}/.steam/root/compatibilitytools.d";
    PROTON_ENABLE_WAYLAND = 1;
    PROTON_DXVK_LOWLATENCY = 1;

    LUA_PATH = "${pkgs.luarocks}/share/lua/5.1/?.lua;${pkgs.luarocks}/share/lua/5.1/?/init.lua;;";
    LUA_CPATH = "${pkgs.luarocks}/lib/lua/5.1/?.so;;";
  };
}
