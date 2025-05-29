{ config, pkgs, lib, ... }:
{
  wayland.windowManager.hyprland = {
    enable = true;
    
    settings = {
      # Variables
      "$mod" = "SUPER";
      "$left" = "h";
      "$down" = "j";
      "$up" = "k";
      "$right" = "l";
      "$terminal" = "kitty";
      "$menu" = "rofi -normal-window";

      # Monitor configuration
      monitor = [
        "DP-2,1920x1080@360,0x0,1"
        ",preferred,auto,1"
      ];

      # Input configuration
      input = {
        accel_profile = "flat";
        sensitivity = 0;
        follow_mouse = 1;
        kb_layout = "us,ru";
        kb_options = "grp:ctrl_space_toggle";
      };



      # General settings
      general = {
        gaps_in = 4;
        gaps_out = 4;
        border_size = 4;
        "col.active_border" = lib.mkForce "rgb(${config.lib.stylix.colors.base05})";
        "col.inactive_border" = lib.mkForce "rgb(${config.lib.stylix.colors.base03})";
        layout = "dwindle";
        allow_tearing = false;
      };

      # Decoration
      decoration = {
        rounding = 10;
        active_opacity = 1.0;
        inactive_opacity = 1.0;
        
        blur = {
          enabled = true;
          size = 5;
          passes = 1;
        };

        shadow = {
          enabled = true;
          range = 4;
          render_power = 3;
        };
      };

      # Group configuration
      group = {
        groupbar = {
          enabled = false;
        };
        "col.border_active" = lib.mkForce "rgb(${config.lib.stylix.colors.base05})";
        "col.border_inactive" = lib.mkForce "rgb(${config.lib.stylix.colors.base03})";
      };

      # Animations
      animations = {
        enabled = true;
        bezier = [
          "linear, 0, 0, 1, 1"
          "md3_standard, 0.2, 0, 0, 1"
          "md3_decel, 0.05, 0.7, 0.1, 1"
          "md3_accel, 0.3, 0, 0.8, 0.15"
          "overshot, 0.05, 0.9, 0.1, 1.1"
          "crazyshot, 0.1, 1.5, 0.76, 0.92"
          "hyprnostretch, 0.05, 0.9, 0.1, 1.0"
          "menu_decel, 0.1, 1, 0, 1"
          "menu_accel, 0.38, 0.04, 1, 0.07"
          "easeInOutCirc, 0.85, 0, 0.15, 1"
          "easeOutCirc, 0, 0.55, 0.45, 1"
          "easeOutExpo, 0.16, 1, 0.3, 1"
          "softAcDecel, 0.26, 0.26, 0.15, 1"
          "md2, 0.4, 0, 0.2, 1" # use with .2s duration
        ];
        animation = [
          "windows, 1, 3, md3_decel, popin 80%"
          "windowsIn, 1, 3, md3_decel, popin 80%"
          "windowsOut, 1, 3, md3_accel, popin 80%"
          "border, 1, 10, default"
          "fade, 1, 3, md3_decel"
          "layersIn, 1, 3, menu_decel, slide"
          "layersOut, 1, 1.6, menu_accel"
          "fadeLayersIn, 1, 2, menu_decel"
          "fadeLayersOut, 1, 0.5, menu_accel"
          "workspaces, 1, 3, menu_decel, slide"
          "specialWorkspace, 1, 3, md3_decel, slidevert"
        ];
      };
    # Animation configs

      # Layout
      dwindle = {
        pseudotile = true;
        preserve_split = true;
      };

      # Misc
      misc = {
        force_default_wallpaper = 0;
        disable_hyprland_logo = true;
        vrr = 1; # adaptive sync
      };

      # Blur eww bar
      layerrule = [
        "blur, waybar"
        "blur, rofi"
      ];

      # Window rules
      windowrule = [
        "float, class:^(org.pulseaudio.pavucontrol)$"
        "float, class:^(nemo)$"
      ];

      # Key bindings
      bind = [
        # Basic bindings
        "$mod, F10, exec, $terminal"
        "$mod, BACKSPACE, killactive"
        "ALT, SPACE, exec, $menu -show drun -normal-window"
        "$mod, RETURN, exec, $menu -show powermenu"
        "$mod, F11, exec, hyprctl reload"
        "$mod, TAB, workspace, previous"
        
        # Movement
        "$mod, $left, movefocus, l"
        "$mod, $down, movefocus, d"
        "$mod, $up, movefocus, u"
        "$mod, $right, movefocus, r"

        "$mod SHIFT, $left, movewindow, l"
        "$mod SHIFT, $down, movewindow, d"
        "$mod SHIFT, $up, movewindow, u"
        "$mod SHIFT, $right, movewindow, r"

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
        "$mod, A, workspace, name:A"
        "$mod, B, workspace, name:B"
        "$mod, C, workspace, name:C"
        "$mod, D, workspace, name:D"
        "$mod, E, workspace, name:E"
        "$mod, F, workspace, name:F"
        "$mod, G, workspace, name:G"
        "$mod, I, workspace, name:I"
        "$mod, M, workspace, name:M"
        "$mod, N, workspace, name:N"
        "$mod, O, workspace, name:O"
        "$mod, P, workspace, name:P"
        "$mod, Q, workspace, name:Q"
        "$mod, R, workspace, name:R"
        "$mod, S, workspace, name:S"
        "$mod, T, workspace, name:T"
        "$mod, U, workspace, name:U"
        "$mod, V, workspace, name:V"
        "$mod, W, workspace, name:W"
        "$mod, X, workspace, name:X"
        "$mod, Y, workspace, name:Y"
        "$mod, Z, workspace, name:Z"

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
        "$mod SHIFT, A, movetoworkspace, name:A"
        "$mod SHIFT, B, movetoworkspace, name:B"
        "$mod SHIFT, C, movetoworkspace, name:C"
        "$mod SHIFT, D, movetoworkspace, name:D"
        "$mod SHIFT, E, movetoworkspace, name:E"
        "$mod SHIFT, F, movetoworkspace, name:F"
        "$mod SHIFT, G, movetoworkspace, name:G"
        "$mod SHIFT, I, movetoworkspace, name:I"
        "$mod SHIFT, M, movetoworkspace, name:M"
        "$mod SHIFT, N, movetoworkspace, name:N"
        "$mod SHIFT, O, movetoworkspace, name:O"
        "$mod SHIFT, P, movetoworkspace, name:P"
        "$mod SHIFT, Q, movetoworkspace, name:Q"
        "$mod SHIFT, R, movetoworkspace, name:R"
        "$mod SHIFT, S, movetoworkspace, name:S"
        "$mod SHIFT, T, movetoworkspace, name:T"
        "$mod SHIFT, U, movetoworkspace, name:U"
        "$mod SHIFT, V, movetoworkspace, name:V"
        "$mod SHIFT, W, movetoworkspace, name:W"
        "$mod SHIFT, X, movetoworkspace, name:X"
        "$mod SHIFT, Y, movetoworkspace, name:Y"
        "$mod SHIFT, Z, movetoworkspace, name:Z"

        # Layout bindings
        "$mod, SLASH, layoutmsg, togglesplit"
        "$mod, COMMA, togglegroup"
        "$mod, j, changegroupactive, b"
        "$mod, k, changegroupactive, f"
        "$mod CTRL, F, fullscreen"
        "$mod, APOSTROPHE, togglefloating"
        "$mod, SPACE, focusurgentorlast"

        # Scratchpad (special workspace)
        "$mod, BRACKETRIGHT, movetoworkspace, special"
        "$mod, BRACKETLEFT, togglespecialworkspace"
        "$mod, BACKSLASH, togglefloating"

        # Resizing
        "$mod, MINUS, resizeactive, -50 0"
        "$mod, EQUAL, resizeactive, 50 0"

        # Monitor movement
        "$mod SHIFT, RIGHT, movewindow, mon:+1"
        "$mod SHIFT, LEFT, movewindow, mon:-1"
        "$mod SHIFT, UP, movewindow, mon:+1"
        "$mod SHIFT, DOWN, movewindow, mon:-1"

        # Screenshots
        ", PRINT, exec, grim"
        "ALT SHIFT, 4, exec, grim -g \"$(slurp)\" ${config.home.homeDirectory}/$(date +'%Y-%m-%d-%H%M%S_screenshot.png')"
      ];

      # Mouse bindings
      bindm = [
        "$mod, mouse:272, movewindow"
        "$mod, mouse:273, resizewindow"
      ];

      # Media keys
      bindl = [
        ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
        ", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 1%- && ${config.home.homeDirectory}/dotfiles/scripts/volume-notify.sh"
        ", XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 1%+ && ${config.home.homeDirectory}/dotfiles/scripts/volume-notify.sh"
        ", XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
        ", XF86MonBrightnessDown, exec, brightnessctl set 5%-"
        ", XF86MonBrightnessUp, exec, brightnessctl set 5%+"
      ];

      # Mouse wheel workspace switching
      binde = [
        "$mod, mouse_down, workspace, e+1"
        "$mod, mouse_up, workspace, e-1"
      ];

      # Startup applications
      exec-once = [
        "hyprctl dispatch workspace name:T"
        "waybar"
        "nm-applet"
        "blueman-applet"
        "pasystray"
      ];

      # Environment variables
      env = [
        "XCURSOR_THEME,capitaine-cursors"
        "XCURSOR_SIZE,16"
      ];
    };
  };
}
