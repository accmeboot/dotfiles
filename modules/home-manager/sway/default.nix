{ pkgs, config, ... }:

let stylixColors = config.lib.stylix.colors;
in {
  home.packages = with pkgs; [
    wl-clipboard
    grim
    slurp
    wireplumber
    playerctl
    brightnessctl
    wiremix
    tray-tui
    xdg-utils
  ];

  wayland.windowManager.sway = {
    enable = true;
    wrapperFeatures.gtk = true;

    config = {
      modifier = "Mod4";
      terminal = "ghostty";
      menu = "qs ipc call dmenu toggle";
      output = {
        "*" = {
          bg = "${config.stylix.image} fill";
          adaptive_sync = "on";
        };
        "DP-2" = { resolution = "2560x1440@240Hz"; };
      };
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
          border = "#${stylixColors.base0D}";
          background = "#${stylixColors.base0D}";
          text = "#${stylixColors.base00}";
          indicator = "#${stylixColors.base0D}";
          childBorder = "#${stylixColors.base0D}";
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

      bars = [ ];

      startup = [
        { command = "swaylock -f"; }
        { command = "sleep 5; systemctl --user start kanshi.service"; }
        { command = "solaar --window=hide"; }
        { command = "${../../../scripts/stylix-autotheme-switch.sh}"; }
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

