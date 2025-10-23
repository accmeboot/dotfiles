{ config, pjgs, ... }: {
  programs.waybar = {
    enable = true;
    settings = {
      mainBar = {
        layer = "bottom";
        position = "top";
        
        modules-left = [ "custom/launcher" "hyprland/workspaces" ];
        modules-center = [ "mpris" "cava" ];
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


        mpris = {
          format = "{status_icon}  {dynamic}";
          interval = 1;
          dynamic-len = 40;
          title-len = 40;
          status-icons = {
            paused = " ";
            playing = " ";
            stopped = " ";
          };
        };

        cava = {
          framerate = 60;
          autosens = 1;
          bars = 14;
          method = "pulse";
          source = "auto";
          stereo = true;
          reverse = false;
          bar_delimiter = 0;
          monstercat = false;
          waves = false;
          noise_reduction = 0.77;
          input_delay = 2;
          sleep_timer = 1;
          hide_on_silence = true;
          format-icons = ["▁" "▂" "▃" "▄" "▅" "▆" "▇" "█" ];
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
        background-color: alpha(#${config.theme.colors.base00}, ${toString config.theme.opacity});
        padding: ${toString config.theme.spacing.xs}px ${toString config.theme.spacing.s}px;
        box-shadow: 0px ${toString config.theme.spacing.xs}px 3px 0px alpha(#151515, 0.4);
        margin: 0px 0px ${toString (config.theme.spacing.s)}px 0px;
      }

      window#waybar {
        background-color: transparent;
        color: #${config.theme.colors.base05};
        font-family: "Inter", monospace;
      }

      .modules-left, .modules-right {
        background-color: alpha(#${config.theme.colors.base00}, 1.0);
        padding: ${toString config.theme.spacing.xs}px ${toString config.theme.spacing.s}px;
        border-radius: ${toString config.theme.borderRadius}px;
        border-width: ${toString config.theme.borderWidth}px;
        border: ${toString config.theme.borderWidth}px solid alpha(#${config.theme.colors.base01}, 1.0);
      }

      .modules-left {
        padding: 0px ${toString config.theme.spacing.s}px;
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


      #workspaces button:hover {
        box-shadow: 0px -${toString config.theme.borderWidth}px 0px #${config.theme.colors.base02} inset;
      }

      #workspaces button.active {
        background-color: transparent;
        box-shadow: 0px -${toString config.theme.borderWidth}px 0px #${config.theme.colors.base0D} inset;
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
