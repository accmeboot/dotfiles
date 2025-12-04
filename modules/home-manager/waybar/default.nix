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

        modules-left = [ "image#launcher" "niri/workspaces" ];
        modules-center = [ "niri/window" ];
        modules-right = [ "tray" "battery" "clock" ];

        spacing = theme.spacing.m;

        "niri/workspaces" = {
          format = "";
          on-scroll-up = "hyprctl dispatch workspace e+1";
          on-scroll-down = "hyprctl dispatch workspace e-1";
          cursor = 60;
        };

        "image#launcher" = {
          path = ../../../assets/icons/nixos.png;
          cursor = 60;
          size = 20;
          on-click = "rofi -show menu";
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
          spacing = theme.spacing.m;
          icon-size = 20;
          cursor = 60;
          icons = { jamesdsp = ../../../assets/icons/eq.png; };
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
        font-size: 14px;
      }

      tooltip {
        border-radius: ${toString theme.borderRadius}px;
        background-color: #${colors.base01};
      }

      tooltip label {
        color: #${colors.base05};
      }

      #workspaces {
        background-color: #${colors.base01};
        margin: ${toString theme.spacing.xs}px 0px;
        border-radius: ${toString theme.borderRadius}px;
      }

      #workspaces button {
        all: unset;
        font-weight: bold;
        margin: ${toString theme.spacing.xs}px;
        background-color: #${colors.base04};
        color: #${colors.base03};
        border-radius: 999px;
        font-size: ${toString (theme.spacing.m * 0.7)}px;
        min-width: ${toString theme.spacing.m}px
      }

      #workspaces button:hover {
        background-color: alpha(#${colors.base04}, 0.5);
      }

      #workspaces button.active {
        background-color: #${colors.base0D};
        min-width: ${toString theme.spacing.xxl}px
      }

      #workspaces button.urgent {
        color: #${colors.base08};
      }

      #tray * {
        border-radius: ${toString theme.borderRadius}px;
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
        font-weight: bold;
      }
    '';
  };
}
