{ config, ... }:
let
  theme = config.stylix.theme;
  colors = config.lib.stylix.colors;
in {
  home.file.".config/waybar/launcher.svg".text = ''
    <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 128 128"><path fill="#${colors.base0D}" d="M50.732 43.771L20.525 96.428l-7.052-12.033 8.14-14.103-16.167-.042L2 64.237l3.519-6.15 23.013.073 8.27-14.352 13.93-.037zm2.318 42.094l60.409.003-6.827 12.164-16.205-.045 8.047 14.115-3.45 6.01-7.05.008-11.445-20.097-16.483-.034-6.996-12.124zm35.16-23.074l-30.202-52.66L71.888 10l8.063 14.148 8.12-14.072 6.897.002 3.532 6.143-11.57 20.024 8.213 14.386-6.933 12.16z" clip-rule="evenodd" fill-rule="evenodd"/><path fill="#${colors.base0D}" d="M39.831 65.463l30.202 52.66-13.88.131-8.063-14.148-8.12 14.072-6.897-.002-3.532-6.143 11.57-20.024-8.213-14.386 6.933-12.16zm35.08-23.207l-60.409-.003L21.33 30.09l16.204.045-8.047-14.115 3.45-6.01 7.051-.01 11.444 20.097 16.484.034 6.996 12.124zm2.357 42.216l30.207-52.658 7.052 12.034-8.141 14.102 16.168.043L126 64.006l-3.519 6.15-23.013-.073-8.27 14.352-13.93.037z" clip-rule="evenodd" fill-rule="evenodd"/></svg>
  '';

  home.file.".config/waybar/eq.svg".text = ''
    <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="#${colors.base05}" stroke-width="2" stroke-linecap="round">
      <line x1="4" y1="9" x2="4" y2="15"/>
      <line x1="8" y1="6" x2="8" y2="18"/>
      <line x1="12" y1="3" x2="12" y2="21"/>
      <line x1="16" y1="6" x2="16" y2="18"/>
      <line x1="20" y1="9" x2="20" y2="15"/>
    </svg>
  '';

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
          path = "${config.xdg.configHome}/waybar/launcher.svg";
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
          icons = {
            jamesdsp = "${config.xdg.configHome}/waybar/eq.svg";
            steam = "steam";
          };
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
        background-color: #${colors.base02};
        margin: ${toString theme.spacing.xs}px 0px;
        border-radius: ${toString theme.borderRadius}px;
      }

      #workspaces button {
        all: unset;
        font-weight: bold;
        margin: ${toString theme.spacing.xs}px;
        background-color: #${colors.base04};
        color: #${colors.base04};
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
