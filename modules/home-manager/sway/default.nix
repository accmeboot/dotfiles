{ pkgs, config, ... }:

let stylixColors = config.lib.stylix.colors;
in {
  home.packages = with pkgs; [
    bemenu
    swayidle
    wl-clipboard
    grim
    wireplumber
    playerctl
    brightnessctl
    wiremix
    tray-tui
  ];

  wayland.windowManager.sway = {
    enable = true;
    wrapperFeatures.gtk = true;

    config = {
      modifier = "Mod4";
      terminal = "ghostty";
      menu = ''
        bemenu-run \
          -p '❯' \
          -H ${toString (config.stylix.fonts.sizes.popups + 13)} \
          --fn '${config.stylix.fonts.sansSerif.name} ${
            toString config.stylix.fonts.sizes.popups
          }' \
          --hp 8 \
          --cw 1 \
          --tf '#${stylixColors.base05}' \
          --tb '#${stylixColors.base00}' \
          --ff '#${stylixColors.base05}' \
          --fb '#${stylixColors.base00}' \
          --cf '#${stylixColors.base05}' \
          --cb '#${stylixColors.base00}' \
          --nf '#${stylixColors.base05}' \
          --nb '#${stylixColors.base00}' \
          --hf '#${stylixColors.base00}' \
          --hb '#${stylixColors.base05}' \
          --fbf '#${stylixColors.base0D}' \
          --fbb '#${stylixColors.base00}' \
          --sf '#${stylixColors.base00}' \
          --sb '#${stylixColors.base05}' \
          --af '#${stylixColors.base05}' \
          --ab '#${stylixColors.base00}'
      '';

      # Output configuration
      output = {
        "*" = { bg = "${../../../assets/wallpapers/fire.png} fill"; };
        "DP-2" = { resolution = "2560x1440@240Hz"; };
      };

      # Input configuration
      input = {
        "type:pointer" = {
          accel_profile = "flat";
          pointer_accel = "0";
        };
        "type:touchpad" = {
          tap = "disabled";
          accel_profile = "adaptive";
          dwt = "enabled";
          middle_emulation = "enabled";
        };
        "type:keyboard" = {
          xkb_layout = "us,ru";
          xkb_options = "grp:alt_shift_toggle";
        };
      };

      colors = {
        focused = {
          border = "#${stylixColors.base05}";
          background = "#${stylixColors.base05}";
          text = "#${stylixColors.base00}";
          indicator = "#${stylixColors.base05}";
          childBorder = "#${stylixColors.base05}";
        };
        focusedInactive = {
          border = "#${stylixColors.base01}";
          background = "#${stylixColors.base01}";
          text = "#${stylixColors.base05}";
          indicator = "#${stylixColors.base01}";
          childBorder = "#${stylixColors.base01}";
        };
        unfocused = {
          border = "#${stylixColors.base01}";
          background = "#${stylixColors.base01}";
          text = "#${stylixColors.base05}";
          indicator = "#${stylixColors.base01}";
          childBorder = "#${stylixColors.base01}";
        };
        urgent = {
          border = "#${stylixColors.base08}";
          background = "#${stylixColors.base08}";
          text = "#${stylixColors.base00}";
          indicator = "#${stylixColors.base08}";
          childBorder = "#${stylixColors.base08}";
        };
      };

      gaps = {
        inner = 4;
        outer = 8;
      };

      bars = [{
        position = "top";

        trayOutput = "none";

        statusCommand = "${../../../scripts/sway-status.sh}";

        fonts = {
          names = [ config.stylix.fonts.sansSerif.name ];
          size = config.stylix.fonts.sizes.popups * 1.0;
        };

        colors = {
          statusline = "#${stylixColors.base05}";
          background = "#${stylixColors.base00}";
          focusedWorkspace = {
            border = "#${stylixColors.base05}";
            background = "#${stylixColors.base05}";
            text = "#${stylixColors.base00}";
          };
          activeWorkspace = {
            border = "#${stylixColors.base05}";
            background = "#${stylixColors.base05}";
            text = "#${stylixColors.base00}";
          };
          inactiveWorkspace = {
            border = "#${stylixColors.base01}";
            background = "#${stylixColors.base01}";
            text = "#${stylixColors.base05}";
          };
          urgentWorkspace = {
            border = "#${stylixColors.base08}";
            background = "#${stylixColors.base08}";
            text = "#${stylixColors.base00}";
          };
          bindingMode = {
            border = "#${stylixColors.base0A}";
            background = "#${stylixColors.base0A}";
            text = "#${stylixColors.base00}";
          };
        };
      }];

      startup =
        [{ command = "sleep 5; systemctl --user start kanshi.service"; }];
    };

    # Extra config for idle and includes
    extraConfig = ''
      # Idle configuration
      exec swayidle -w \
           timeout 300 'swaylock' \
           timeout 600 'swaymsg "output * power off"' resume 'swaymsg "output * power on"' \
           before-sleep 'swaylock'

      # Special keys to adjust volume via PipeWire
      bindsym --locked XF86AudioMute exec wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
      bindsym --locked XF86AudioLowerVolume exec wpctl set-volume @DEFAULT_AUDIO_SINK@ 1%-
      bindsym --locked XF86AudioRaiseVolume exec wpctl set-volume @DEFAULT_AUDIO_SINK@ 1%+
      bindsym --locked XF86AudioMicMute exec wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle
    '';
  };
}

