{ config, ... }:
let
  theme = config.stylix.theme;
  colors = config.lib.stylix.colors;
in {
  programs.waybar = {
    enable = true;
    settings = {
      mainBar = {
        layer = "top";
        position = "top";

        modules-left = [ "niri/workspaces" "niri/window" ];
        modules-center = [ ];
        modules-right = [ "tray" "battery" "clock" ];

        spacing = theme.spacing.m;

        "niri/workspaces" = {
          format = "{value}";
          on-scroll-up = "hyprctl dispatch workspace e+1";
          on-scroll-down = "hyprctl dispatch workspace e-1";
          cursor = 60;
        };

        "niri/window" = {
          icon = true;
          icon-size = 20;
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
          format = "{icon}";
          tooltip-format = "{capacity}%";
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

        tray = {
          spacing = theme.spacing.m
            + 2; # 2 is needed because icons are rendered by font take 2 cells
          icon-size = 20;
          cursor = 60;
        };
      };
    };

    style = ''
      * {
        border: none;
        border-radius: 0px;
        min-height: 0px;
      }

      window#waybar>box {
        background-color: #${colors.base00};
        padding: 0px ${toString theme.spacing.s}px;
      }

      window#waybar {
        background-color: transparent;
        color: #${colors.base05};
        font-size: 16px;
      }

      tooltip {
        border-radius: ${toString theme.borderRadius}px;
        background-color: #${colors.base01};
      }

      tooltip label {
        color: #${colors.base05};
      }

      #workspaces button {
        all: unset;
        font-weight: bold;
        padding: 0px ${toString theme.spacing.xs}px;
        margin: ${toString theme.spacing.xs}px;
        background-color: transparent;
        border-radius: ${toString theme.borderRadius}px;
        min-width: ${toString (theme.spacing.s + theme.spacing.xs)}px;
      }

      #workspaces button:hover {
        background-color: #${colors.base02};
      }

      #workspaces button.active {
        background-color: #${colors.base0D};
        color: #${colors.base0D};
      }

      #workspaces button.urgent {
        color: #${colors.base08};
      }

      #tray * {
        border-radius: ${toString theme.borderRadius}px;
        font-size: 14px;
      }

      #battery {
        color: #${colors.base05};
      }

      #battery.warning {
        color: #${colors.base0A};
      }

      #battery.critical {
        color: #${colors.base08};
      }

      #battery {
        font-size: 18px;
        font-weight: bold;
      }

      #window, #clock {
        font-size: 14px;
        font-weight: bold;
      }

    '';
  };
}
