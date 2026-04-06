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

        modules-left = [ "custom/launcher" "clock" "mpris" ];
        modules-center = [ "hyprland/workspaces" ];
        modules-right = [
          "cava"
          "battery"
          "pulseaudio"
          "pulseaudio#source"
          "network"
          "custom/tray"
        ];

        spacing = 8;

        "custom/launcher" = {
          format = "";
          tooltip-format = "System menu";
          on-click = "rofi -show menu";
        };

        mpris = {
          format = "    {status_icon} {dynamic}";
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
          input_delay = 1;
          sleep_timer = 1;
          hide_on_silence = true;
          format-icons = [ "⣀" "⣤" "⣶" "⣿" ];
        };

        "custom/tray" = {
          format = "";
          tooltip-format = "Tray menu";
          on-click = "ghostty --class=com.accme.float --command=tray-tui";
        };

        "hyprland/workspaces" = {
          format = "{id}{icon}";
          format-icons = {
            default = "*";
            empty = " ";
          };
          persistent-workspaces = { "*" = [ 1 2 3 4 5 6 7 8 9 ]; };
          on-scroll-up = "hyprctl dispatch workspace e+1";
          on-scroll-down = "hyprctl dispatch workspace e-1";
          cursor = 60;
        };

        network = {
          format = "{ifname}";
          format-wifi = "<span foreground='#${colors.base0B}'>󰤨</span> {essid}";
          format-ethernet =
            "<span foreground='#${colors.base0B}'>󰖟</span> {bandwidthTotalBits}";
          format-disconnected =
            "<span foreground='#${colors.base0B}'>󰪎</span> {bandwidthTotalBits}";
          tooltip-format = "Network: {ifname}";
          tooltip-format-wifi = "{essid} ({signalStrength}%)";
          tooltip-format-disconnected = "Disconnected";
          max-length = 50;
          on-click = "ghostty --class=com.accme.float --command=nmtui";
        };

        pulseaudio = {
          format = "<span foreground='#${colors.base09}'></span> {volume}%";
          format-muted =
            "<span foreground='#${colors.base09}'></span> {volume}%";
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
            "<span foreground='#${colors.base08}'>{icon}</span> {capacity}%";
          tooltip-format = "Battery: {capacity}%";
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
      };

      secondBar = {
        layer = "bottom";
        position = "top";
        exclusive = false;
        height = 12;
        name = "secondBar";

        expand-left = true;
        expand-right = true;

        modules-left = [ ];
        modules-center = [ ];
        modules-right = [ ];
      };

      bottomBar = {
        layer = "bottom";
        position = "bottom";
        exclusive = false;
        height = 12;
        name = "bottomBar";

        expand-left = true;
        expand-right = true;

        modules-left = [ ];
        modules-center = [ ];
        modules-right = [ ];
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
        background-color: alpha(#${colors.base00}, ${toString opacity});
        color: #${colors.base05};
      }

      .modules-left {
        padding-left: ${toString rounding}px;
      }

      .modules-right {
        padding-right: ${toString rounding}px;
      }

      tooltip {
        border-radius: ${toString rounding}px;
        background-color: #${colors.base01};
      }

      tooltip label {
        color: #${colors.base05};
      }

      #custom-launcher, #custom-tray {
        font-size: 20px;
      }

      #workspaces, #pulseaudio, #pulseaudio.source, #battery, #network {
        background-color: #${colors.base01};
        border-radius: ${toString rounding}px;
        margin: 4px 0px;
        padding: 4px 8px;
      }

      #workspaces button {
        all: unset;
        padding: 0px 8px;
        background-color: transparent;
        border-radius: 0px;
        min-width: 12px;
      }

      #workspaces button:hover {
        color: alpha(#${colors.base0D}, 0.5);
      }

      #workspaces button.active {
        color: transparent;
        background-image: url("${../../../assets/icons/nama-tama.png}");
        background-position: center;
        background-repeat: no-repeat;
        background-size: contain;
      }

      #workspaces button.urgent {
        color: #${colors.base08};
      }

      #clock, #cava, #mpris {
        font-size: 14px;
      }

      window#waybar.secondBar {
        background-color: transparent;
      }

      window#waybar.secondBar .modules-left {
        border-top-left-radius: ${toString rounding}px;
        background-color: transparent;
        box-shadow: -${toString rounding}px -${toString rounding}px 0 ${
          toString rounding
        }px alpha(#${colors.base00}, ${toString opacity});
      }

      window#waybar.secondBar .modules-right {
        border-top-right-radius: ${toString rounding}px;
        background-color: transparent;
        box-shadow: ${toString rounding}px -${toString rounding}px 0 ${
          toString rounding
        }px alpha(#${colors.base00}, ${toString opacity});
      }

      window#waybar.bottomBar {
        background-color: transparent;
      }

      window#waybar.bottomBar .modules-left {
        border-bottom-left-radius: ${toString rounding}px;
        background-color: transparent;
        box-shadow: -${toString rounding}px ${toString rounding}px 0 ${
          toString rounding
        }px alpha(#${colors.base00}, ${toString opacity});
      }

      window#waybar.bottomBar .modules-right {
        border-bottom-right-radius: 12px;
        background-color: transparent;
        box-shadow: ${toString rounding}px ${toString rounding}px 0 ${
          toString rounding
        }px alpha(#${colors.base00}, ${toString opacity});
      }
    '';
  };
}
