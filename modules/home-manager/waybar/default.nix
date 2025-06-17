{ config, pkgs, ... }: {
  programs.waybar = {
    enable = true;
    settings = {
      mainBar = {
        layer = "bottom";
        position = "top";
        
        modules-left = [ "hyprland/workspaces" ];
        modules-center = [];
        modules-right = [
          "custom/cpu"
          "custom/separator"
          "custom/gpu"
          "custom/separator"
          "clock"
          "custom/separator"
          "hyprland/language"
          "custom/separator"
          "battery"
          "tray"
        ];

        spacing = config.theme.spacing.s;

        "hyprland/workspaces" = {
          format = "{name}";
          on-scroll-up = "hyprctl dispatch workspace e+1";
          on-scroll-down = "hyprctl dispatch workspace e-1";
          cursor = 60;
        };

        "custom/separator" = {
          format = "󰿟";
          tooltip = false;
        };

        "battery" = {
          interval = 60;
          states = {
            warning = 30;
            critical = 16;
          };

          format = "[{capacity}%] 󰿟";
        };

        "custom/cpu" = {
          format = "CPU: {text}°C";
          exec = "bash ${../../../scripts/cpu-temp.sh}";
          return-type = "json";
          interval = 1;
          cursor = 68;
          tooltip = false;
        };

        "custom/gpu" = {
          format = "GPU: {text}°C";
          exec = "bash ${../../../scripts/gpu-temp.sh}";
          return-type = "json";
          interval = 1;
          cursor = 68;
          tooltip = false;
        };

        "hyprland/language" = {
          format = "{}";
          format-en = "EN";
          format-ru = "RU";
          cursor = 68;
          tooltip = false;
        };

        clock = {
          format = "{:%H:%M}";
          tooltip-format = "{:%A, %d %b %Y, %H:%M}";
          on-click = "xdg-open https://calendar.google.com/";
        };

        tray = {
          spacing = config.theme.spacing.s;
          icon-size = 14;
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
        padding: ${toString config.theme.spacing.s}px;
      }

      window#waybar {
        background-color: alpha(#${config.theme.colors.base00}, 0.0);
        color: #${config.theme.colors.base05};
        font-family: "DepartureMono Nerd Font", monospace;
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
    '';
  };
}
