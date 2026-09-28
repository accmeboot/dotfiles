{ pkgs, lib, config, ... }:
let
  dwl =
    (pkgs.dwl.override {
      configH = import ./config.nix;
    }).overrideAttrs
      (old: {
        patches = (old.patches or [ ]) ++ import ./patches.nix { inherit pkgs; };
      });
in
{
  home.packages = [
    dwl
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

  # dwl has no output or autostart config; these run once dwl-session.target is up.
  systemd.user.services = {
    dwl-outputs = {
      Unit = {
        Description = "Configure dwl outputs";
        PartOf = [ "dwl-session.target" ];
        After = [ "dwl-session.target" ];
      };
      Service = {
        Type = "oneshot";
        ExecStart = pkgs.writeShellScript "dwl-outputs" ''
          wlr_randr=${lib.getExe pkgs.wlr-randr}

          for output in $($wlr_randr --json | ${lib.getExe pkgs.jq} -r '.[].name'); do
            $wlr_randr --output "$output" --adaptive-sync enabled
          done

          $wlr_randr --output DP-2 --mode 2560x1440@239.970001Hz || true
        '';
      };
      Install.WantedBy = [ "dwl-session.target" ];
    };

    solaar = {
      Unit = {
        Description = "Solaar";
        PartOf = [ "dwl-session.target" ];
        After = [ "dwl-session.target" ];
      };
      Service.ExecStart = "${lib.getExe pkgs.solaar} --window=hide";
      Install.WantedBy = [ "dwl-session.target" ];
    };
  };
}
