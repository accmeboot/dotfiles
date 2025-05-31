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
        modules-right = [ "group/temps" "custom/kblayout" "tray" "clock" ];

        "group/spaces" = {
          orientation = "horizontal";
          modules = ["custom/launcher" "hyprland/workspaces"];
        };

        "hyprland/window" = {
          format = "{title}";
          tooltip = false;
          on-click-middle = "hyprctl dispatch killactive";
        };

        "hyprland/workspaces" = {
          format = "{name}";
          on-scroll-up = "hyprctl dispatch workspace e+1";
          on-scroll-down = "hyprctl dispatch workspace e-1";
        };

        "custom/launcher" = {
          format = " ";
          on-click = "rofi -show drun";
        };

        "custom/cpu" = {
          format = "  {text}°C";
          exec = "sensors | grep 'Tctl:' | awk '{print int($2)}' | sed 's/[^0-9.]*//g'";
          interval = 1;
        };

        "custom/gpu" = {
          format = "   {text}°C";
          exec = "sensors | awk '/edge/ {if (!found) {print int($2); found=1}}'";
          interval = 1;
        };

        "custom/ram" = {
          format = "  {text}%";
          exec = "free -m | awk '/^Mem:/ {printf \"%d\", $3/$2 * 100}'";
          interval = 1;
        };

        "group/temps" = {
          orientation = "horizontal";
          modules = ["custom/cpu" "custom/gpu" "custom/ram"];
        };

        "custom/kblayout" = {
          format = "   {text}";
          exec = "hyprctl devices -j | jq -r '.keyboards[] | select(.main == true) | .active_keymap' | awk '{print toupper(substr($0,1,2))}'";
          interval = 1;
        };

        clock = {
          format = "{:%A, %d %b %Y, %H:%M}";
          tooltip = false;
          format-alt = "{:%A, %d %b %Y, %H:%M}";
        };

        tray = {
          spacing = 10;
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
        padding:0 4px;
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

      #custom-cpu {
        color: #${config.lib.stylix.colors.base08};
      }
      #custom-gpu {
        color: #${config.lib.stylix.colors.base09};
        margin: 0px 10px;
      }
      #custom-ram {
        color: #${config.lib.stylix.colors.base0B};
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
