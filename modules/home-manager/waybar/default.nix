{ config, ... }:
let
  colors = config.lib.stylix.colors;
  font = config.stylix.fonts.serif.name;
  rounding = config.stylix.desktop.rounding;
  opacity = config.stylix.desktop.opacity;
in {
  programs.waybar = {
    enable = true;
    settings = {
      mainBar = {
        layer = "bottom";
        position = "top";
        margin = "8 8 0 8";
        modules-left = [ "custom/launcher" "custom/temps" ];
        modules-center = [ "hyprland/workspaces" ];
        modules-right = [
          "battery"
          "pulseaudio"
          "pulseaudio#source"
          "network"
          "clock"
          "custom/notifications"
        ];

        spacing = 8;

        "custom/launcher" = {
          format = "<span foreground='#${colors.base09}'></span>";
          tooltip-format = "System menu";
          on-click = "rofi -show menu";
        };

        "custom/notifications" = {
          exec = ''
            if [ "$(dunstctl is-paused)" = "true" ]; then
              echo '{"text":"󰂛","tooltip":"Notifications (do not disturb)"}'
            else
              echo '{"text":"󰂚","tooltip":"Notifications (click to show history)"}'
            fi
          '';
          return-type = "json";
          format = "<span color='#${colors.base09}'>{}</span>";
          interval = 2;
          on-click = "dunstctl history-pop";
          on-click-middle = "dunstctl set-paused toggle";
          cursor = 60;
        };

        "custom/temps" = {
          exec =
            "echo $(${config.home.homeDirectory}/dotfiles/scripts/cpu-temp.sh)° $(${config.home.homeDirectory}/dotfiles/scripts/gpu-temp.sh)°";
          format = "<span foreground='#${colors.base0A}'></span> {}";
          interval = 5;
          tooltip-format = "System Temperatures: {}";
        };

        "hyprland/workspaces" = {
          format = "{id}";
          persistent-workspaces = { "*" = [ 1 2 3 4 5 6 7 8 9 ]; };
          on-scroll-up = "hyprctl dispatch workspace e+1";
          on-scroll-down = "hyprctl dispatch workspace e-1";
          cursor = 60;
        };

        network = {
          format = "{ifname}";
          format-wifi = "<span foreground='#${colors.base0A}'>󰤨</span> {essid}";
          format-ethernet =
            "<span foreground='#${colors.base0A}'>󰖟</span> {bandwidthTotalBits}";
          format-disconnected =
            "<span foreground='#${colors.base0A}'>󰪎</span> {bandwidthTotalBits}";
          tooltip-format = "Network: {ifname}";
          tooltip-format-wifi = "{essid} ({signalStrength}%)";
          tooltip-format-disconnected = "Disconnected";
          max-length = 50;
          on-click = "ghostty --class=com.accme.float --command=nmtui";
        };

        pulseaudio = {
          format = "<span foreground='#${colors.base0A}'></span> {volume}%";
          format-muted =
            "<span foreground='#${colors.base0A}'></span> {volume}%";
          scroll-step = 1;
          on-click =
            "ghostty --class=com.accme.float --command='wiremix -v output'";
        };

        "pulseaudio#source" = {
          format = "{format_source}";
          format-source =
            "<span foreground='#${colors.base0A}'></span> {volume}%";
          format-source-muted =
            "<span foreground='#${colors.base0A}'>󰍭</span> {volume}%";
          tooltip-format = "{source_desc}";
          scroll-step = 1;
          on-scroll-up = "wpctl set-volume @DEFAULT_AUDIO_SOURCE@ 1%+";
          on-scroll-down = "wpctl set-volume @DEFAULT_AUDIO_SOURCE@ 1%-";
          on-click =
            "ghostty --class=com.accme.float --command='wiremix -v input'";
        };

        battery = {
          interval = 1;
          states = {
            warning = 30;
            critical = 16;
          };
          events = {
            on-discharging-warning =
              "notify-send -u normal -i battery-caution 'Low Battery'";
            on-discharging-critical =
              "notify-send -u critical -i battery-empty 'Very Low Battery'";
            on-charging-100 =
              "notify-send -u normal -i battery-full-charged 'Battery Full!'";
          };
          format =
            "<span foreground='#${colors.base0A}'>{icon}</span> {capacity}%";
          tooltip-format = "Battery: {capacity}%";
          format-icons = {
            default = [ "󰂎" "󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹" ];
            charging = [ "󰢟" "󰢜" "󰂆" "󰂇" "󰂈" "󰢝" "󰂉" "󰢞" "󰂊" "󰂋" "󰂅" ];
            plugged = "󰚥";
          };
          max-length = 25;
        };

        clock = {
          format = "<span foreground='#${colors.base0A}'>󰖉</span> {:%H:%M}";
          tooltip-format = "{:%A, %d %b %Y, %H:%M}";
          on-click = "xdg-open https://calendar.google.com/";
        };
      };
    };

    style = ''
      * {
        border: none;
        border-radius: 0px;
        min-height: 0px;
        font-size: 16px;
        font-family: ${font};
      }

      window#waybar {
        background-color: transparent;
        color: #${colors.base05};
      }

      tooltip {
        border-radius: ${toString rounding}px;
        background-color: #${colors.base01};
      }

      tooltip label {
        color: #${colors.base05};
      }

      #custom-notifications, #custom-launcher {
        font-size: 20px;
      }

      .modules-left, .modules-right, .modules-center {
        background-color: alpha(#${colors.base01}, ${toString opacity});
        border-radius: ${toString rounding}px;
        padding: 0px 8px;
        border: 1px solid #${colors.base03};
      }

      #workspaces {
        padding: 4px 0px;
      }

      #workspaces button {
        all: unset;
        margin: 0px 4px;
        padding: 0px 4px;
        background-color: transparent;
        border-radius: 0px;
        min-width: 12px;
      }

      #workspaces button.active {
        box-shadow: inset 0px -1px #${colors.base0D};
      }

      #workspaces button.urgent {
        color: #${colors.base08};
      }
    '';
  };
}
