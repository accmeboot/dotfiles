{ config, ... }: {
  programs.waybar = {
    enable = true;
    settings = {
      mainBar = {
        layer = "bottom";
        position = "top";

        modules-left =
          [ "hyprland/workspaces" "custom/separator" "hyprland/window" ];
        modules-center = [ ];
        modules-right =
          [ "tray" "custom/separator" "battery" "pulseaudio" "clock" ];

        spacing = config.theme.spacing.s;

        "hyprland/workspaces" = {
          format = "{id}";
          on-scroll-up = "hyprctl dispatch workspace e+1";
          on-scroll-down = "hyprctl dispatch workspace e-1";
          cursor = 60;
          persistent-workspaces = { "*" = 5; };
        };

        "hyprland/window" = { format = " {title}"; };
        "custom/separator" = { format = ""; };

        pulseaudio = {
          format = "{icon} {volume}%";
          format-muted = "  {volume}%";
          format-icons = [ " " " " " " ];
          scroll-step = 1;
          on-click = "wezterm -e --class com.accme.float wiremix -v output";
        };

        "battery" = {
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
          format = "{icon} {capacity}%";
          format-icons = {
            default = [ "󰂎" "󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹" ];
            charging =
              [ "󰢟 " "󰢜 " "󰂆 " "󰂇 " "󰂈 " "󰢝 " "󰂉 " "󰢞 " "󰂊 " "󰂋 " "󰂅 " ];
            plugged = "󰚥";
          };
          max-length = 25;
        };

        clock = {
          format = "{:%H:%M}";
          tooltip-format = "{:%A, %d %b %Y, %H:%M}";
          on-click = "xdg-open https://calendar.google.com/";
        };

        tray = {
          spacing = config.theme.spacing.s;
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
        background-color: #${config.theme.colors.base00};
        padding: 0px ${toString config.theme.spacing.s}px;
        box-shadow: 4px 4px 2px 1px alpha(#1B1610, 0.6);
        margin: 0px 0px ${toString config.theme.spacing.s}px 0px;
      }

      window#waybar {
        background-color: transparent;
        color: #${config.theme.colors.base05};
        font-size: 16px;
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
        margin: ${toString config.theme.spacing.xs}px 0px;
        background-color: transparent;
        border-radius: ${toString config.theme.borderRadius}px;
      }

      #workspaces button:hover {
        background-color: #${config.theme.colors.base03};
      }

      #workspaces button.active {
        background-color: #${config.theme.colors.base0D};
        color: #${config.theme.colors.base0D};
      }

      #workspaces button.urgent {
        color: #${config.theme.colors.base08};
      }

      #tray * {
        border-radius: ${toString config.theme.borderRadius}px;
      }

      #clock, #pulseaudio {
        padding: 0px;
        margin: 0px;
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

      window#waybar.empty #window {
        font-size: 0;
        margin: 0;
        padding: 0;
      }
    '';
  };
}
