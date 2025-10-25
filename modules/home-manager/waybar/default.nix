{ config, ... }:
{
  programs.waybar = {
    enable = true;
    settings = {
      mainBar = {
        layer = "bottom";
        position = "top";
        
        modules-left = [ "custom/launcher" "hyprland/workspaces" ];
        modules-center = [ "custom/stats" ];
        modules-right = [
          "tray"
          "battery"
          "clock"
        ];

        spacing = config.theme.spacing.s;

        "hyprland/workspaces" = {
          format = "{name}";
          on-scroll-up = "hyprctl dispatch workspace e+1";
          on-scroll-down = "hyprctl dispatch workspace e-1";
          cursor = 60;
        };

        "custom/stats" = {
          format = "{text}";
          exec = "${../../../scripts/stats/get-stats.sh}";
          interval = 5;
          on-click = "kitty --class float btop";
        };

        "custom/separator" = {
          format = "󰿟";
          tooltip = false;
        };

        "custom/launcher" = {
          format = "󰝘 ";
          on-click = "kitty --class fzflauncher ${../../../scripts/launcher/menu.sh}";
          tooltip-format = "System menu";
        };

        "battery" = {
          interval = 1;
          states = {
            warning = 30;
            critical = 16;
          };
          events = {
            on-discharging-warning = "notify-send -u normal 'Low Battery'";
            on-discharging-critical = "notify-send -u critical 'Very Low Battery'";
            on-charging-100 = "notify-send -u normal 'Battery Full!'";
          };
          format = "{icon}";
          format-icons = {
            default = [ "󰂎" "󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹" ];
            charging = [ "󰢟 " "󰢜 " "󰂆 " "󰂇 " "󰂈 " "󰢝 " "󰂉 " "󰢞 " "󰂊 " "󰂋 " "󰂅 " ];
            plugged = "󰚥";
          };
          max-length = 25;
        };

        clock = {
          format = "{:%A, %d %b %Y, %H:%M}";
          tooltip-format = "{:%A, %d %b %Y, %H:%M}";
          on-click = "xdg-open https://calendar.google.com/";
        };

        tray = {
          spacing = config.theme.spacing.s;
          icon-size = 16;
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
        background-color: alpha(#${config.theme.colors.base00}, 1.0);
        padding: 0px ${toString (config.theme.spacing.s + config.theme.borderRadius + config.theme.borderWidth)}px;
      }

      window#waybar {
        background-color: transparent;
        color: #${config.theme.colors.base05};
        font-family: "Inter", monospace;
      }

      tooltip {
        border-radius: ${toString config.theme.borderRadius}px;
        background-color: #${config.theme.colors.base01};
      }

      tooltip label {
        color: #${config.theme.colors.base05};
      }

      #workspaces button {
        all: unset;
        padding: ${toString config.theme.spacing.s}px;
        background-color: transparent;
      }


      #workspaces button:hover {
        box-shadow: 0px -2px 0px #${config.theme.colors.base02} inset;
      }

      #workspaces button.active {
        background-color: transparent;
        box-shadow: 0px -2px 0px #${config.theme.colors.base05} inset;
      }

      #workspaces button.urgent {
        background-color: transparent;
        color: #${config.theme.colors.base08};
      }

      #tray * {
        font-family: "Inter", monospace;
        border-radius: ${toString config.theme.borderRadius}px;
      }

      #clock {
        padding: 0px;
      }

      #battery {
        font-size: 18px;
      }

      #battery {
        color: #${config.theme.colors.base05};
      }

      #battery.warning {
        color: #${config.theme.colors.base0A};
      }

      #battery.critical {
        color: #${config.theme.colors.base08};
      }
    '';
  };
}
