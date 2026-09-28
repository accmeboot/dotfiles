{ pkgs, lib, ... }:
let
  wlopm = lib.getExe pkgs.wlopm;
in
{
  services.hypridle = {
    enable = true;
    systemdTarget = "dwl-session.target";
    settings = {
      general = {
        after_sleep_cmd = "${wlopm} --on '*'";
        ignore_dbus_inhibit = false;
        lock_cmd = "qs -c mesa-shell ipc call lock lock";
        before_sleep_cmd = "loginctl lock-session";
      };

      listener = [
        {
          timeout = 300;
          on-timeout = "qs -c mesa-shell ipc call lock lock";
        }
        {
          timeout = 360;
          on-timeout = "${wlopm} --off '*'";
          on-resume = "${wlopm} --on '*'";
        }
        {
          timeout = 480;
          on-timeout = "systemctl suspend";
        }
      ];
    };
  };
}
