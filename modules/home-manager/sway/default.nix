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
      window = {
        titlebar = false;
        border = 3;
      };
      gaps = {
        inner = 4;
        outer = 6;
      };
      menu = "${pkgs.rofi}/bin/rofi -show run";
      output = {
        "*" = { bg = "${config.stylix.image} fill"; };
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

      keybindings = let
        modifier = config.wayland.windowManager.sway.config.modifier;
        terminal = config.wayland.windowManager.sway.config.terminal;
        menu = config.wayland.windowManager.sway.config.menu;
      in {
        # Terminal
        "${modifier}+Return" = "exec ${terminal}";

        # Kill focused window
        "${modifier}+Shift+q" = "kill";

        # Reload configuration
        "${modifier}+Shift+c" = "reload";

        # Exit sway
        "${modifier}+Shift+e" =
          "exec swaynag -t warning -m 'You pressed the exit shortcut. Do you really want to exit sway? This will end your Wayland session.' -b 'Yes, exit sway' 'swaymsg exit'";

        # Start launcher
        "${modifier}+d" = "exec ${menu}";

        # Focus
        "${modifier}+h" = "focus left";
        "${modifier}+j" = "focus down";
        "${modifier}+k" = "focus up";
        "${modifier}+l" = "focus right";
        "${modifier}+Left" = "focus left";
        "${modifier}+Down" = "focus down";
        "${modifier}+Up" = "focus up";
        "${modifier}+Right" = "focus right";

        # Move
        "${modifier}+Shift+h" = "move left";
        "${modifier}+Shift+j" = "move down";
        "${modifier}+Shift+k" = "move up";
        "${modifier}+Shift+l" = "move right";
        "${modifier}+Shift+Left" = "move left";
        "${modifier}+Shift+Down" = "move down";
        "${modifier}+Shift+Up" = "move up";
        "${modifier}+Shift+Right" = "move right";

        # Workspaces
        "${modifier}+1" = "workspace one";
        "${modifier}+2" = "workspace two";
        "${modifier}+3" = "workspace three";
        "${modifier}+4" = "workspace four";
        "${modifier}+5" = "workspace five";
        "${modifier}+6" = "workspace six";
        "${modifier}+7" = "workspace seven";
        "${modifier}+8" = "workspace eight";
        "${modifier}+9" = "workspace nine";
        "${modifier}+0" = "workspace ten";

        # Move to workspace
        "${modifier}+Shift+1" = "move container to workspace one";
        "${modifier}+Shift+2" = "move container to workspace two";
        "${modifier}+Shift+3" = "move container to workspace three";
        "${modifier}+Shift+4" = "move container to workspace four";
        "${modifier}+Shift+5" = "move container to workspace five";
        "${modifier}+Shift+6" = "move container to workspace six";
        "${modifier}+Shift+7" = "move container to workspace seven";
        "${modifier}+Shift+8" = "move container to workspace eight";
        "${modifier}+Shift+9" = "move container to workspace nine";
        "${modifier}+Shift+0" = "move container to workspace ten";

        # Layout
        "${modifier}+b" = "splith";
        "${modifier}+v" = "splitv";
        "${modifier}+f" = "fullscreen toggle";
        "${modifier}+a" = "focus parent";
        "${modifier}+s" = "layout stacking";
        "${modifier}+w" = "layout tabbed";
        "${modifier}+e" = "layout toggle split";

        # Floating
        "${modifier}+Shift+space" = "floating toggle";
        "${modifier}+space" = "focus mode_toggle";

        # Scratchpad
        "${modifier}+Shift+minus" = "move scratchpad";
        "${modifier}+minus" = "scratchpad show";

        # Resize mode
        "${modifier}+r" = "mode resize";
      };

      modes = {
        resize = {
          "h" = "resize shrink width 10 px";
          "j" = "resize grow height 10 px";
          "k" = "resize shrink height 10 px";
          "l" = "resize grow width 10 px";
          "Left" = "resize shrink width 10 px";
          "Down" = "resize grow height 10 px";
          "Up" = "resize shrink height 10 px";
          "Right" = "resize grow width 10 px";
          "Return" = "mode default";
          "Escape" = "mode default";
        };
      };

      bars = [{
        position = "top";

        trayOutput = "none";

        statusCommand = "i3status";

        fonts = {
          names = [ config.stylix.fonts.sansSerif.name ];
          size = config.stylix.fonts.sizes.popups * 1.0;
        };

        colors = {
          statusline = "#${stylixColors.base05}";
          background = "#${stylixColors.base00}";
          focusedWorkspace = {
            border = "#${stylixColors.base0D}";
            background = "#${stylixColors.base0D}";
            text = "#${stylixColors.base00}";
          };
          activeWorkspace = {
            border = "#${stylixColors.base0D}";
            background = "#${stylixColors.base0D}";
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

