{ pkgs, config, ... }:

let stylixColors = config.lib.stylix.colors;
in {
  home.packages = with pkgs; [
    swayidle
    wl-clipboard
    grim
    slurp
    wireplumber
    playerctl
    brightnessctl
    wiremix
    tray-tui
    xdg-utils
    sway-audio-idle-inhibit
  ];

  wayland.windowManager.sway = {
    enable = true;
    wrapperFeatures.gtk = true;

    config = {
      modifier = "Mod4";
      terminal = "ghostty";
      window = {
        titlebar = false;
        border = 2;
      };
      menu = "bemenu-run ${config.programs.bemenu.opts}";

      # Output configuration
      output = {
        "*" = { bg = "${config.stylix.image} fill"; };
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

      bars = [{
        position = "top";

        trayOutput = "none";

        # statusCommand = "${../../../scripts/sway-status.sh}";
        statusCommand = "i3status";

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

      startup = [
        { command = "sleep 5; systemctl --user start kanshi.service"; }
        { command = "sway-audio-idle-inhibit"; }
      ];
    };

    extraConfig = ''
      # Special keys to adjust volume via PipeWire
      bindsym --locked XF86AudioMute exec wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
      bindsym --locked XF86AudioLowerVolume exec wpctl set-volume @DEFAULT_AUDIO_SINK@ 1%-
      bindsym --locked XF86AudioRaiseVolume exec wpctl set-volume @DEFAULT_AUDIO_SINK@ 1%+
      bindsym --locked XF86AudioMicMute exec wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle

      # Special keys to control media via playerctl
      bindsym --locked XF86AudioPlay exec playerctl play-pause
      bindsym --locked XF86AudioPause exec playerctl play-pause
      bindsym --locked XF86AudioPrev exec playerctl previous
      bindsym --locked XF86AudioNext exec playerctl next
      bindsym --locked XF86AudioStop exec playerctl stop

      # Special keys to adjust brightness via brightnessctl
      bindsym --locked XF86MonBrightnessDown exec brightnessctl set 1%-
      bindsym --locked XF86MonBrightnessUp exec brightnessctl set 1%+

      # Special key to take a screenshot with grim
      bindsym Print exec grim
    '';
  };
}

