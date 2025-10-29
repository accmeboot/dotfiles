{ config, ... }:
{
  programs.waybar = {
    enable = true;
    settings = {
      mainBar = {
        layer = "bottom";
        position = "top";
        
        modules-left = [ "custom/launcher" "hyprland/workspaces" ];
        modules-center = [ "custom/stats" "pulseaudio" ];
        modules-right = [
          "tray"
          "battery"
          "clock"
        ];

        spacing = config.theme.spacing.s;

        "hyprland/workspaces" = {
          format = "{icon}";
          on-scroll-up = "hyprctl dispatch workspace e+1";
          on-scroll-down = "hyprctl dispatch workspace e-1";
          cursor = 60;
          format-icons = {
            active = "󰮯";
            default = "";
          };
          persistent-workspaces = {
           "*" = 5;
          };
        };

        "custom/stats" = {
          format = "{text}";
          exec = "${../../../scripts/stats/get-stats.sh}";
          interval = 1;
          on-click = "ghostty --class=com.accme.float --command=btop";
        };

        pulseaudio = {
          format = " VOL: {volume}%";
          format-bluetooth = " VOL: {volume}%";
          format-muted = " VOL: {volume}% [MUTED]";
          scroll-step = 1;
          on-click = "ghostty --class=com.accme.float --command='wiremix -v output'";
        };

        "custom/separator" = {
          format = "󰿟";
          tooltip = false;
        };

        "custom/launcher" = {
          format = "";
          on-click = "ghostty --class=com.accme.fzflauncher --command=${../../../scripts/launcher/menu.sh}";
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
        background-color: transparent;
        padding: 0px;
      }

      window#waybar {
        background-color: transparent;
        color: #${config.theme.colors.base05};
        font-family: "Inter", monospace;
      }

      .modules-left, .modules-right, .modules-center {
        background-color: alpha(#${config.theme.colors.base00}, ${toString config.theme.opacity});
        padding: 0px ${toString config.theme.spacing.s}px;
        border-radius: ${toString config.theme.borderRadius}px;
        box-shadow: 4px 4px 2px 1px alpha(#${config.theme.colors.base00}, ${toString config.theme.opacity});
        margin: ${toString config.theme.spacing.s}px;
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
        padding: ${toString config.theme.spacing.xs}px;
        background-color: transparent;
      }

      #workspaces button:hover {
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

      #clock, #pulseaudio, #custom-stats {
        padding: 0px;
        margin: 0px;
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

      #custom-launcher {
        font-size: 20px;
        color: #${config.theme.colors.base0B};
      }
    '';
  };
}
