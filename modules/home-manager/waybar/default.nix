{ config, pkgs, ... }: {
  programs.waybar = {
    enable = true;
    settings = {
      mainBar = {
        layer = "bottom";
        position = "top";
        height = 32;
        
        modules-left = [ "hyprland/workspaces" "hyprland/window" ];
        modules-center = [];
        modules-right = [ "tray" "hyprland/language" "group/temps" "clock" ];

        spacing = config.theme.spacing.m;

        "hyprland/window" = {
          format = "{title}";
          tooltip = false;
          icon = true;
          icon-size = 12;
          on-click = "rofi -show window";
          on-click-right = "hyprctl dispatch killactive";
        };

        "hyprland/workspaces" = {
          format = "{name}";
          on-scroll-up = "hyprctl dispatch workspace e+1";
          on-scroll-down = "hyprctl dispatch workspace e-1";
          cursor = 60;
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

        "custom/ram" = {
          format = "RAM: {text}%";
          exec = "bash ${../../../scripts/ram-usage.sh}";
          return-type = "json";
          interval = 1;
          cursor = 68;
          tooltip = false;
        };

        "group/temps" = {
          orientation = "horizontal";
          modules = ["custom/cpu" "custom/gpu" "custom/ram"];
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
        background-color: transparent;
        color: #${config.theme.colors.base05};
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
        box-shadow: inset 0 -${toString (config.theme.borderWidth * 2)}px transparent;
      }

      #workspaces button.active {
        background-color: transparent;
        box-shadow: inset 0 -${toString (config.theme.borderWidth * 2)}px #${config.theme.colors.base0A};
      }

      #workspaces button.urgent {
        background-color: transparent;
        color: #${config.theme.colors.base08};
        box-shadow: inset 0 -${toString (config.theme.borderWidth * 2)}px transparent;
      }

      #custom-cpu.normal, #custom-gpu.normal, #custom-ram.normal {
        color: #${config.theme.colors.base0B};
      }
      #custom-cpu.medium, #custom-gpu.medium, #custom-ram.medium {
        color: #${config.theme.colors.base0A};
      }
      #custom-cpu.high, #custom-gpu.high, #custom-ram.high {
        color: #${config.theme.colors.base08};
      }

      #custom-gpu {
        margin: 0px ${toString config.theme.spacing.xs}px;
      }

      #tray * {
        border-radius: ${toString config.theme.borderRadius}px;
      }

      #clock {
        padding: 0px;
      }
    '';
  };
}
