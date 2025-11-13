{ ... }: {
  services.hypridle = {
    enable = true;
    settings = {
      general = {
        after_sleep_cmd = "niri msg action power-on-monitors";
        ignore_dbus_inhibit = false;
        lock_cmd = "pidof hyprlock || hyprlock";
      };

      listener = [
        {
          timeout = 300;
          on-timeout = "hyprlock";
        }
        {
          timeout = 600;
          on-timeout = "niri msg action power-off-monitors";
          on-resume = "niri msg action power-on-monitors";
        }
        {
          timeout = 700;
          on-timeout = "systemctl suspend";
        }
      ];
    };
  };
}
