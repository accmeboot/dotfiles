{ config, lib, ... }: {
  wayland.windowManager.hyprland = {
    enable = true;

    # set the Hyprland and XDPH packages to null to use the ones from the NixOS module
    package = null;
    portalPackage = null;

    systemd.variables = [ "--all" ];

    settings = {
      # Variables
      "$mod" = "SUPER";
      "$left" = "h";
      "$down" = "j";
      "$up" = "k";
      "$right" = "l";
      "$terminal" = "ghostty";
      "$menu" = "$terminal --class=com.accme.fzflauncher --command=${
          ../../../scripts/launcher/menu.sh
        }";

      # Monitor configuration
      monitor = [ ",highrr,auto,1" ];

      xwayland = { force_zero_scaling = true; };

      device = {
        name = "asuf1205:00-2808:0106-touchpad";
        accel_profile = "adaptive";
      };

      # Input configuration
      input = {
        accel_profile = "flat";
        sensitivity = -0.25;
        follow_mouse = 1;
        kb_layout = "us,ru";
        kb_options = "grp:ctrl_space_toggle";

        touchpad = {
          natural_scroll = true;
          scroll_factor = 0.5;
          middle_button_emulation = false;
          tap-and-drag = true;
          drag_lock = false;
          disable_while_typing = true;
          clickfinger_behavior = true;
          tap-to-click = false;
        };
      };

      # General settings
      general = {
        gaps_in = config.theme.spacing.xs;
        gaps_out = "0,${toString config.theme.spacing.s},${
            toString config.theme.spacing.s
          },${toString config.theme.spacing.s}";
        float_gaps = config.theme.spacing.m;
        border_size = config.theme.borderWidth;
        layout = "dwindle";
        allow_tearing = false;
      };

      # Decoration
      decoration = {
        rounding = config.theme.borderRadius;

        blur = {
          enabled = true;
          size = 8;
          passes = 3;
        };

        shadow = {
          enabled = true;
          range = 2;
          render_power = 1;
          offset = "4 4";
          color = lib.mkForce "rgba(1B161099)";
        };

        dim_inactive = true;
        dim_strength = 0.2;
      };

      animations = { enabled = false; };

      # Group configuration
      group = {
        groupbar = {
          enabled = false;
          stacked = false;
        };
      };

      # Layout
      dwindle = {
        pseudotile = true;
        preserve_split = true;
      };

      # Misc
      misc = {
        force_default_wallpaper = 0;
        disable_hyprland_logo = true;
        vrr = 2; # adaptive sync
      };

      # Window rules
      windowrule = [
        "float, class:nemo"
        "float, class:com.accme.float"
        "size 800 600, class:com.accme.float"

        "center, floating:1"

        "float, class:com.accme.fzflauncher"
        "size 320 360, class:com.accme.fzflauncher"
        "pin, class:com.accme.fzflauncher"
        "stayfocused, class:com.accme.fzflauncher"
      ];

      # Key bindings
      bind = [
        # Basic bindings
        "$mod, Q,   exec, $terminal"
        "$mod, C,   killactive"
        "$mod, F,   togglefloating"
        "$mod, R,   exec, $menu"
        "$mod, W,   exec, $terminal --class com.accme.float -o tab_bar_min_tabs=2 wiremix -v output"
        "$mod, S,   togglesplit"
        "$mod, M,   exec, bash ${../../../scripts/hypr-group.sh}"

        "$mod, j,   changegroupactive, b"
        "$mod, k,   changegroupactive, f"

        "$mod, E,   fullscreen"
        "$mod, TAB, focusurgentorlast"

        # Movement
        "$mod, $left,  movefocus, l"
        "$mod, $down,  movefocus, d"
        "$mod, $up,    movefocus, u"
        "$mod, $right, movefocus, r"

        "$mod SHIFT,   $left, movewindow, l"
        "$mod SHIFT,   $down, movewindow, d"
        "$mod SHIFT,   $up, movewindow, u"
        "$mod SHIFT,   $right, movewindow, r"

        # Workspaces
        "$mod, 1, workspace, 1"
        "$mod, 2, workspace, 2"
        "$mod, 3, workspace, 3"
        "$mod, 4, workspace, 4"
        "$mod, 5, workspace, 5"
        "$mod, 6, workspace, 6"
        "$mod, 7, workspace, 7"
        "$mod, 8, workspace, 8"
        "$mod, 9, workspace, 9"

        # Move container to workspace
        "$mod SHIFT, 1, movetoworkspace, 1"
        "$mod SHIFT, 2, movetoworkspace, 2"
        "$mod SHIFT, 3, movetoworkspace, 3"
        "$mod SHIFT, 4, movetoworkspace, 4"
        "$mod SHIFT, 5, movetoworkspace, 5"
        "$mod SHIFT, 6, movetoworkspace, 6"
        "$mod SHIFT, 7, movetoworkspace, 7"
        "$mod SHIFT, 8, movetoworkspace, 8"
        "$mod SHIFT, 9, movetoworkspace, 9"

        # Special workspace)
        "$mod, BRACKETRIGHT, movetoworkspace, special"
        "$mod, BRACKETLEFT, togglespecialworkspace"

        # Resizing
        "$mod, MINUS, resizeactive, -50 0"
        "$mod, EQUAL, resizeactive, 50 0"

        # Monitor movement
        "$mod SHIFT, RIGHT, movewindow, mon:+1"
        "$mod SHIFT, LEFT, movewindow, mon:-1"
        "$mod SHIFT, UP, movewindow, mon:+1"
        "$mod SHIFT, DOWN, movewindow, mon:-1"

        # Screenshots
        ''
          , PRINT, exec, filename="${config.home.homeDirectory}/Screenshots/$(date +'%Y-%m-%d-%H%M%S_screenshot.png')" && grim "$filename" && wl-copy < "$filename" && notify-send 'Screenshot' "Full screen captured\nSaved to: $filename\nCopied to clipboard" -i "$filename"''
        ''
          ALT SHIFT, 4, exec, filename="${config.home.homeDirectory}/Screenshots/$(date +'%Y-%m-%d-%H%M%S_screenshot.png')" && grim -g "$(slurp)" "$filename" && wl-copy < "$filename" && notify-send 'Screenshot' "Area selection captured\nSaved to: $filename\nCopied to clipboard" -i "$filename"''
      ];

      # Mouse bindings
      bindm = [ "$mod, mouse:272, movewindow" "$mod, mouse:273, resizewindow" ];

      # Media keys
      bindl = [
        ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
        ", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 1%-"
        ", XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 1%+"
        ", XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
        ", XF86MonBrightnessDown, exec, brightnessctl set 5%-"
        ", XF86MonBrightnessUp, exec, brightnessctl set 5%+"

        ", switch:on:Lid Switch, exec, hyprlock & systemctl suspend"
      ];

      # Mouse wheel workspace switching
      binde =
        [ "$mod, mouse_down, workspace, e+1" "$mod, mouse_up, workspace, e-1" ];

      # Startup applications
      exec-once = [
        "hyprctl dispatch exec 'sleep 0.5 && hyprlock -q'"
        "waybar"
        "nm-applet"
        "blueman-applet"
        "wpctl set-volume @DEFAULT_AUDIO_SINK@ 50%"
      ];

      # Environment variables
      env = [ "XCURSOR_THEME,capitaine-cursors" "XCURSOR_SIZE,16" ];
    };
  };
}
