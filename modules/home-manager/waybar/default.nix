{ config, ... }:
let
  colors = config.lib.stylix.colors;
  font = config.stylix.fonts.serif.name;
  rounding = config.stylix.desktop.rounding;
in {
  programs.waybar = {
    enable = true;
    settings = {
      mainBar = {
        layer = "bottom";
        position = "top";
        margin = "8 8 0 8";
        modules-left = [ "custom/launcher" "clock" "mpris" ];
        modules-center = [ "hyprland/workspaces" ];
        modules-right = [
          "tray"
          "custom/separator"
          "battery"
          "pulseaudio"
          "pulseaudio#source"
          "network"
        ];

        spacing = 8;

        "custom/launcher" = {
          format = "";
          tooltip-format = "System menu";
          on-click = "rofi -show menu";
        };

        "custom/separator" = { format = ""; };

        tray = {
          icon-size = 20;
          spacing = 8;
          cursor = 60;
          icons = {
            indicator-solaar = ../../../assets/icons/g-hub.png;
            solaar = ../../../assets/icons/g-hub.png;
            steam = ../../../assets/icons/steam.png;
          };
        };

        mpris = {
          format = "{status_icon} {dynamic}";
          interval = 1;
          dynamic-len = 40;
          title-len = 40;
          status-icons = {
            paused = " ";
            playing = " ";
            stopped = " ";
          };
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
          format-wifi = "󰤨 {essid}";
          format-ethernet = "󰖟 {bandwidthTotalBits}";
          format-disconnected = "󰪎 {bandwidthTotalBits}";
          tooltip-format = "Network: {ifname}";
          tooltip-format-wifi = "{essid} ({signalStrength}%)";
          tooltip-format-disconnected = "Disconnected";
          max-length = 50;
          on-click = "ghostty --class=com.accme.float --command=nmtui";
        };

        pulseaudio = {
          format = " {volume}%";
          format-muted = " {volume}%";
          scroll-step = 1;
          on-click =
            "ghostty --class=com.accme.float --command='wiremix -v output'";
        };

        "pulseaudio#source" = {
          format = "{format_source}";
          format-source = " {volume}%";
          format-source-muted = "󰍭 {volume}%";
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
          format = "{icon} {capacity}%";
          tooltip-format = "Battery: {capacity}%";
          format-icons = {
            default = [ "󰂎" "󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹" ];
            charging = [ "󰢟" "󰢜" "󰂆" "󰂇" "󰂈" "󰢝" "󰂉" "󰢞" "󰂊" "󰂋" "󰂅" ];
            plugged = "󰚥";
          };
          max-length = 25;
        };

        clock = {
          format = "{:%H:%M}";
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

      #custom-launcher {
        font-size: 24px;
      }

      .modules-left, .modules-right, .modules-center {
        background-color: #${colors.base01};
        border-radius: ${toString rounding}px;
        padding: 0px 4px;
        border: 1px solid #${colors.base03};
      }

      #pulseaudio.source, #battery, #network, #mpris, #pulseaudio, #clock {
        padding: 4px;
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

      #workspaces button:hover {
        color: alpha(#${colors.base05}, 0.5);
      }

      #workspaces button.active {
        box-shadow: inset 0px -1px #${colors.base05};
      }

      #workspaces button.urgent {
        color: #${colors.base08};
      }

      #tray * {
        border-radius: ${toString rounding}px;
      }

      #tray {
        margin-left: 4px;
      }
    '';
  };
}
