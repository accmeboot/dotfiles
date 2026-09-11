{ ... }: {
  services.hypridle = {
    enable = true;
    systemdTarget = "sway-session.target";
    settings = {
      general = {
        after_sleep_cmd = "swaymsg 'output * power on'";
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
          on-timeout = "swaymsg 'output * power off'";
          on-resume = "swaymsg 'output * power on'";
        }
        {
          timeout = 480;
          on-timeout = "systemctl suspend";
        }
      ];
    };
  };
}
