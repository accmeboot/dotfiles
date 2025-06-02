{ config, pkgs, ... }: {
  programs.waybar = {
    enable = true;
    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 30;
        
        modules-left = [ "group/spaces" "hyprland/window" ];
        modules-center = [];
        modules-right = [ "tray" "group/temps" "custom/kblayout" "clock" ];

        "group/spaces" = {
          orientation = "horizontal";
          modules = ["custom/launcher" "hyprland/workspaces"];
        };

        "hyprland/window" = {
          format = "{title}";
          tooltip = false;
          icon = true;
          icon-size = 18;
          on-click = "hyprctl dispatch killactive";
        };

        "hyprland/workspaces" = {
          format = "{name}";
          on-scroll-up = "hyprctl dispatch workspace e+1";
          on-scroll-down = "hyprctl dispatch workspace e-1";
          cursor = 60;
        };

        "custom/launcher" = {
          format = " ";
          on-click = "rofi -show drun";
          cursor = 60;
          tooltip-format = "Rofi drun";
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
          cursor = false;
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
          cursor = false;
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
          cursor = false;
          tooltip = false;
        };

        "group/temps" = {
          orientation = "horizontal";
          modules = ["custom/cpu" "custom/gpu" "custom/ram"];
        };

        "custom/kblayout" = {
          format = "   {text}";
          exec = "hyprctl devices -j | jq -r '.keyboards[] | select(.main == true) | .active_keymap' | awk '{print toupper(substr($0,1,2))}'";
          interval = 1;
          cursor = false;
          tooltip = false;
        };

        clock = {
          format = "󱛡  {:%H:%M}";
          tooltip-format = "{:%A, %d %b %Y, %H:%M}";
          on-click = "xdg-open https://calendar.google.com/";
        };

        tray = {
          spacing = 10;
          cursor = 60;
        };
      };
    };

    style = ''
      * {
        border: none;
        border-radius: 0;
        min-height: 0;
      }

      window#waybar>box {
        padding:0 8px;
      }

      window#waybar {
        background-color: transparent;
        color: #${config.lib.stylix.colors.base00};
      }

      tooltip {
        border-radius: 8px;
        background-color: #${config.lib.stylix.colors.base01};
      }

      tooltip label {
        color: #${config.lib.stylix.colors.base05};
      }

      #workspaces {
        margin-left: 8px;
      }

      #workspaces button {
        min-width: 0;
        box-shadow: inset 0 -3px transparent;

        padding: 0px 8px;
        background-color: transparent;
        font-weight: bold;
        color: #${config.lib.stylix.colors.base05};
      }

      #workspaces button.active {
        background-color: #${config.lib.stylix.colors.base00};
        color: #${config.lib.stylix.colors.base0B};
      }

      #workspaces button.urgent {
        background-color: #${config.lib.stylix.colors.base00};
        color: #${config.lib.stylix.colors.base08};
      }

      #clock,
      #tray {
        color: #${config.lib.stylix.colors.base05};
      }

      #tray, #clock, #temps, #custom-kblayout, #spaces {
        background-color: #${config.lib.stylix.colors.base00};
        padding: 2px 10px;
        margin: 2px;
        border-radius: 8px;
      }

      #custom-kblayout {
        color: #${config.lib.stylix.colors.base05};
      }

      #custom-launcher {
        color: #${config.lib.stylix.colors.base0D};
        font-size: 16px;
      }

      #custom-cpu.normal, #custom-gpu.normal, #custom-ram.normal {
        color: #${config.lib.stylix.colors.base0B};
      }
      #custom-cpu.medium, #custom-gpu.medium, #custom-ram.medium {
        color: #${config.lib.stylix.colors.base0A};
      }
      #custom-cpu.high, #custom-gpu.high, #custom-ram.high {
        color: #${config.lib.stylix.colors.base08};
      }

      #custom-gpu {
        margin: 0px 10px;
      }

      #window {
        color: #${config.lib.stylix.colors.base05};
        margin-left: 10px;
      }

      #tray * {
        border-radius: 8;
      }
    '';
  };
}
