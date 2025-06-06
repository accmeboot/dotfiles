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
        modules-right = [ "tray" "custom/kblayout" "group/temps" "clock" ];

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
          exec = ''
            temp=$(sensors | grep 'Tctl:' | awk '{print int($2)}' | sed 's/[^0-9.]*//g')
            if [ "$temp" -lt 50 ]; then
              class="normal"
            elif [ "$temp" -lt 65 ]; then
              class="medium" 
            else
              class="high"
            fi
            echo "{\"text\":\"$temp\",\"class\":\"$class\"}"
          '';
          return-type = "json";
          interval = 1;
          cursor = 68;
          tooltip = false;
        };

        "custom/gpu" = {
          format = "GPU: {text}°C";
          exec = ''
            temp=$(sensors | awk '/edge/ {if (!found) {print int($2); found=1}}')
            if [ "$temp" -lt 50 ]; then
              class="normal"
            elif [ "$temp" -lt 65 ]; then
              class="medium"
            else
              class="high" 
            fi
            echo "{\"text\":\"$temp\",\"class\":\"$class\"}"
          '';
          return-type = "json";
          interval = 1;
          cursor = 68;
          tooltip = false;
        };

        "custom/ram" = {
          format = "RAM: {text}%";
          exec = ''
            usage=$(free -m | awk '/^Mem:/ {printf "%d", $3/$2 * 100}')
            if [ "$usage" -lt 50 ]; then
              class="normal"
            elif [ "$usage" -lt 75 ]; then
              class="medium"
            else
              class="high"
            fi
            echo "{\"text\":\"$usage\",\"class\":\"$class\"}"
          '';
          return-type = "json";
          interval = 1;
          cursor = 68;
          tooltip = false;
        };

        "group/temps" = {
          orientation = "horizontal";
          modules = ["custom/cpu" "custom/gpu" "custom/ram"];
        };

        "custom/kblayout" = {
          format = "{text}";
          exec = "hyprctl devices -j | jq -r '.keyboards[] | select(.main == true) | .active_keymap' | awk '{print toupper(substr($0,1,2))}'";
          interval = 1;
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
        background-color: #${config.theme.colors.base00};
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
        background-color: #${config.theme.colors.base01};
      }

      #workspaces button.active {
        background-color: #${config.theme.colors.base0D};
        color: #${config.theme.colors.base02};
      }

      #workspaces button.urgent {
        background-color: #${config.theme.colors.base08};
        color: #${config.theme.colors.base02};
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
