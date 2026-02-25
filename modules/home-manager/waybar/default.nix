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
          "pulseaudio"
          "pulseaudio#source"
          "hyprland/language"
          "network"
        ];

        spacing = 8;

        "hyprland/workspaces" = {
          format = "{icon}";
          format-icons = {
            "1" = "one";
            "2" = "two";
            "3" = "three";
            "4" = "four";
            "5" = "five";
            "6" = "six";
            "7" = "seven";
            "8" = "eight";
            "9" = "nine";
          };
          persistent-workspaces = { "*" = [ 1 2 3 4 5 6 7 8 9 ]; };
          on-scroll-up = "hyprctl dispatch workspace e+1";
          on-scroll-down = "hyprctl dispatch workspace e-1";
          cursor = 60;
        };

        "hyprland/language" = {
          format =
            "<span foreground='#${colors.base0B}'>KEY</span> {}  <span foreground='#${colors.base03}'>󰇙</span>";
          format-en = "EN";
          format-ru = "RU";
          cursor = 68;
          tooltip = false;
        };

        network = {
          format = "{ifname}";
          format-wifi =
            "<span foreground='#${colors.base0C}'>NET</span> {essid}";
          format-ethernet =
            "<span foreground='#${colors.base0C}'>NET</span> {bandwidthTotalBits}";
          format-disconnected =
            "<span foreground='#${colors.base0C}'><s>NET</s></span> {bandwidthTotalBits}";
          tooltip-format = "Network: {ifname}";
          tooltip-format-wifi = "{essid} ({signalStrength}%)";
          tooltip-format-disconnected = "Disconnected";
          max-length = 50;
          on-click = "nm-connection-editor";
        };

        pulseaudio = {
          format =
            "<span foreground='#${colors.base09}'>VOL</span> {volume}%  <span foreground='#${colors.base03}'>󰇙</span>";
          tooltip = false;
          format-muted =
            "<span foreground='#${colors.base09}'><s>VOL</s></span> {volume}%  <span foreground='#${colors.base03}'>󰇙</span>";
          scroll-step = 1;
          on-click = "wezterm -e --class com.accme.float wiremix -v output";
        };

        "pulseaudio#source" = {
          format = "{format_source}";
          format-source =
            "<span foreground='#${colors.base0A}'>MIC</span> {volume}%  <span foreground='#${colors.base03}'>󰇙</span>";
          format-source-muted =
            "<span foreground='#${colors.base0A}'><s>MIC</s></span> {volume}%  <span foreground='#${colors.base03}'>󰇙</span>";
          tooltip = false;
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
            "<span foreground='#${colors.base08}'>BAT</span> {capacity}%  <span foreground='#${colors.base03}'>󰇙</span>";
          format-charging =
            "<span foreground='#${colors.base08}'>BAT*</span> {capacity}%  <span foreground='#${colors.base03}'>󰇙</span>";
          format-plugged =
            "<span foreground='#${colors.base08}'>BAT+</span> {capacity}%  <span foreground='#${colors.base03}'>󰇙</span>";
          tooltip-format = "Battery: {capacity}%";
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
        background-color: alpha(#${colors.base00}, 0.9);
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
        font-style: italic;
      }

      #workspaces button.empty {
        font-style: normal;
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
    '';
  };
}
