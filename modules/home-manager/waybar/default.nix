{ config, ... }:
let
  colors = config.lib.stylix.colors;
  font = config.stylix.fonts.serif.name;
in {
  programs.waybar = {
    enable = true;
    settings = {
      mainBar = {
        layer = "bottom";
        position = "top";

        modules-left = [ "hyprland/workspaces" ];
        modules-center = [ "clock" ];
        modules-right = [
          "battery"
          "temperature"
          "pulseaudio"
          "pulseaudio#source"
          "network"
        ];

        spacing = 8;

        "hyprland/workspaces" = {
          format = "{id}";
          persistent-workspaces = { "*" = [ 1 2 3 4 5 6 7 8 9 ]; };
          on-scroll-up = "hyprctl dispatch workspace e+1";
          on-scroll-down = "hyprctl dispatch workspace e-1";
          cursor = 60;
        };

        temperature = {
          interval = 10;
          hwmon-path = [
            "/sys/class/hwmon/hwmon7/temp1_input" # Intel coretemp
            "/sys/class/hwmon/hwmon5/temp1_input" # AMD k10temp (common)
            "/sys/class/hwmon/hwmon4/temp1_input" # AMD k10temp (alternative)
            "/sys/class/hwmon/hwmon3/temp1_input" # Fallback
          ];
          critical-threshold = 80;
          format =
            " {temperatureC}°C  <span foreground='#${colors.base05}'>󰇙</span>";
          tooltip-format = "CPU Temperature: {temperatureC}°C";
        };

        network = {
          format = "{ifname}";
          format-wifi = "󰤨 {essid}";
          format-ethernet = "󰖟 {bandwidthTotalBits}";
          format-disconnected = "󰪎 {bandwidthTotalBits}";
          tooltip-format = "Network: {ifname}";
          tooltip-format-wifi = "{essid} ({signalStrength}%)";
          tooltip-format-disconnected = "Disconnected";
          max-length = 50;
          on-click = "nm-connection-editor";
        };

        pulseaudio = {
          format = " {volume}%  <span foreground='#${colors.base05}'>󰇙</span>";
          tooltip-format = "Output: {volume}%";
          format-muted =
            " {volume}%  <span foreground='#${colors.base05}'>󰇙</span>";
          scroll-step = 1;
          on-click = "wezterm -e --class com.accme.float wiremix -v output";
        };

        "pulseaudio#source" = {
          format = "{format_source}";
          format-source =
            " {volume}%  <span foreground='#${colors.base05}'>󰇙</span>";
          format-source-muted =
            "󰍭 {volume}%  <span foreground='#${colors.base05}'>󰇙</span>";
          tooltip-format = "Microphone: {volume}%";
          scroll-step = 1;
          on-click = "wezterm -e --class com.accme.float wiremix -v input";
        };

        battery = {
          interval = 1;
          states = {
            warning = 30;
            critical = 16;
          };
          events = {
            on-discharging-warning = "notify-send -u normal 'Low Battery'";
            on-discharging-critical =
              "notify-send -u critical 'Very Low Battery'";
            on-charging-100 = "notify-send -u normal 'Battery Full!'";
          };
          format =
            "{icon} {capacity}%  <span foreground='#${colors.base05}'>󰇙</span>";
          tooltip-format = "Battery: {capacity}%";
          format-icons = {
            default = [ "󰂎" "󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹" ];
            charging = [ "󰢟" "󰢜" "󰂆" "󰂇" "󰂈" "󰢝" "󰂉" "󰢞" "󰂊" "󰂋" "󰂅" ];
            plugged = "󰚥";
          };
          max-length = 25;
        };

        clock = {
          format = "{:%A %H:%M}";
          tooltip-format = "{:%A, %d %b %Y, %H:%M}";
          on-click = "xdg-open https://calendar.google.com/";
        };
      };
    };

    style = ''
      * {
        border: none;
        border-radius: 0px;
        min-height: 0px;
        font-size: 16px;
        font-family: ${font};
      }

      window#waybar>box {
        padding-right: 8px;
      }

      window#waybar {
        background-color: #${colors.base00};
        color: #${colors.base05};
      }

      tooltip {
        border-radius: 0px;
        background-color: #${colors.base01};
      }

      tooltip label {
        color: #${colors.base05};
      }

      #workspaces button {
        all: unset;
        padding: 4px 8px;
        background-color: transparent;
        border-radius: 0px;
        min-width: 12px;
        color: #${colors.base05};
      }

      #workspaces button.empty {
        color: #${colors.base03};
      }

      #workspaces button:hover {
        background-color: #${colors.base02};
      }

      #workspaces button.active {
        background-color: #${colors.base0D};
        color: #${colors.base00};
      }

      #workspaces button.urgent {
        color: #${colors.base08};
      }

      #temperature {
        color: #${colors.base09};
      }

      #pulseaudio {
        color: #${colors.base0A};
      }
      #pulseaudio.source {
        color: #${colors.base0B};
      }
      #network {
        color: #${colors.base0C};
      }

      #battery {
        color: #${colors.base0E};
      }

      #clock {
        font-size: 14px;
      }
    '';
  };
}
