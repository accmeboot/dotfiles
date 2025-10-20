{ config, pjgs, ... }: {
  programs.waybar = {
    enable = true;
    settings = {
      mainBar = {
        layer = "bottom";
        position = "top";
        
        modules-left = [ "image#launcher" "hyprland/workspaces" "hyprland/window" ];
        modules-center = [ "clock"];
        modules-right = [
          "tray"
          "battery"
        ];

        spacing = config.theme.spacing.s;

        "hyprland/workspaces" = {
          format = "{name}";
          on-scroll-up = "hyprctl dispatch workspace e+1";
          on-scroll-down = "hyprctl dispatch workspace e-1";
          cursor = 60;
        };

        "hyprland/window" = {
          on-click-middle = "hyprctl dispatch killactive";
          icon = true;
          icon-size = 16;
          rewrite = {
            "(.*)-fzf-launcher.sh" = "Drun";
          };
        };

        "custom/separator" = {
          format = "󰿟";
          tooltip = false;
        };

        "image#launcher" = {
          path = "${../../../assets/wallpapers/nixos-icon.svg}";
          size = 16;
          on-click = "kitty --class fzflauncher ${../../../scripts/fzf-launcher.sh}";
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
        padding: 0px ${toString config.theme.spacing.s}px;
      }

      window#waybar {
        background-color: alpha(#${config.theme.colors.base00}, 0.0);
        color: #${config.theme.colors.base05};
        font-family: "Inter", monospace;
      }

      .modules-left, .modules-right {
        background-color: alpha(#${config.theme.colors.base00}, 1.0);
        padding: ${toString config.theme.spacing.xs}px ${toString config.theme.spacing.s}px;
        border-radius: ${toString config.theme.borderRadius}px;
        border-width: ${toString config.theme.borderWidth}px;
        border: ${toString config.theme.borderWidth}px solid #${config.theme.colors.base03};
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
        padding: 0px ${toString config.theme.spacing.s}px;
        background-color: transparent;
      }

      #workspaces button.active {
        background-color: transparent;
        color: #${config.theme.colors.base0D};
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
        color: #${config.theme.colors.base0B};
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
