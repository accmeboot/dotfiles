{ pkgs, lib, ... }:
let
  dwl =
    (pkgs.dwl.override {
      configH = import ./config.nix;
    }).overrideAttrs
      (old: {
        patches = (old.patches or [ ]) ++ import ./patches.nix { inherit pkgs; };
      });

  dwlmsg = import ./dwlmsg { inherit pkgs; };

  # Not using programs.dwl: its session script starts dwl-session.target
  # before dwl runs, so WAYLAND_DISPLAY isn't in the systemd environment yet.
  # WAYLAND_DISPLAY only exists once dwl is running, so the environment is
  # exported and the target started from dwl's startup command.
  dwlSession = pkgs.writeShellScript "dwl-session" ''
    export XDG_CURRENT_DESKTOP=dwl
    export XDG_SESSION_DESKTOP=dwl
    export XDG_SESSION_TYPE=wayland

    ${lib.getExe dwl} -s '
      ${pkgs.dbus}/bin/dbus-update-activation-environment --systemd \
        DISPLAY WAYLAND_DISPLAY XDG_CURRENT_DESKTOP XDG_SESSION_DESKTOP XDG_SESSION_TYPE
      systemctl --user start dwl-session.target
    '

    systemctl --user stop dwl-session.target
  '';
in
{
  environment.systemPackages = [
    dwl
    dwlmsg
  ]
  # used by keybinds in config.nix and scripts/screenshot-*.sh
  ++ (with pkgs; [
    wl-clipboard
    grim
    slurp
    wireplumber
    playerctl
    brightnessctl
    xdg-utils
  ]);

  services.displayManager.sessionPackages = [
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

  xdg.portal.config.dwl.default = [
    "wlr"
    "gtk"
  ];

  systemd.user.targets.dwl-session = {
    description = "dwl compositor session";
    documentation = [ "man:systemd.special(7)" ];
    bindsTo = [ "graphical-session.target" ];
    wants = [ "graphical-session-pre.target" ];
    after = [ "graphical-session-pre.target" ];
  };

  # dwl has no output config; this runs once dwl-session.target is up.
  systemd.user.services = {
    dwl-outputs = {
      description = "Configure dwl outputs";
      partOf = [ "dwl-session.target" ];
      after = [ "dwl-session.target" ];
      wantedBy = [ "dwl-session.target" ];
      serviceConfig = {
        Type = "oneshot";
        ExecStart = pkgs.writeShellScript "dwl-outputs" ''
          wlr_randr=${lib.getExe pkgs.wlr-randr}

          for output in $($wlr_randr --json | ${lib.getExe pkgs.jq} -r '.[].name'); do
            $wlr_randr --output "$output" --adaptive-sync enabled
          done

          $wlr_randr --output DP-2 --mode 2560x1440@239.970001Hz || true
        '';
      };
    };
  };
}
