{ config, ... }:
let stylixColors = config.lib.stylix.colors;
in {
  programs.i3status = {
    enable = true;
    enableDefault = false;

    general = {
      colors = true;
      color_good = "#${stylixColors.base0B}";
      color_degraded = "#${stylixColors.base0A}";
      color_bad = "#${stylixColors.base08}";
      interval = 5;
    };

    modules = {
      "wireless _first_" = {
        position = 1;
        settings = {
          format_up = "WiFi: %quality at %essid";
          format_down = "WiFi: Disconnected";
        };
      };

      "ethernet _first_" = {
        position = 2;
        settings = {
          format_up = "Ethernet: %speed";
          format_down = "Ethernet: Disconnected";
        };
      };

      "battery all" = {
        position = 3;
        settings = {
          format = "%status %percentage %remaining";
          format_down = "Battery: N/A";
          status_chr = "Charging:";
          status_bat = "Battery:";
          status_unk = "Battery: Unknown";
          status_full = "Battery: Full";
          path = "/sys/class/power_supply/BAT%d/uevent";
          low_threshold = 10;
        };
      };

      "disk /" = {
        position = 4;
        settings = { format = "Disk: %avail"; };
      };

      "load" = {
        position = 5;
        settings = { format = "Load: %1min"; };
      };

      "memory" = {
        position = 6;
        settings = {
          format = "Memory: %used / %total";
          threshold_degraded = "1G";
          format_degraded = "Memory: < %available";
        };
      };

      "tztime local" = {
        position = 7;
        settings = { format = "Time: %H:%M"; };
      };
    };
  };
}
