{ ... }: {
  services.hypridle = {
    enable = true;
    settings = {
      general = {
        after_sleep_cmd = "swaymsg 'output * power on'";
        ignore_dbus_inhibit = false;
        lock_cmd = "pidof swaylock || swaylock -f";
      };

      listener = [
        {
          timeout = 300;
          on-timeout = "swaylock -f";
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
