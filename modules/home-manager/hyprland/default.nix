{ config, pkgs, lib, ... }:
{
  wayland.windowManager.hyprland = {
    enable = true;

    # set the Hyprland and XDPH packages to null to use the ones from the NixOS module
    package = null;
    portalPackage = null;

    systemd.variables = ["--all"];
    
    settings = {
      # Variables
      "$mod" = "SUPER";
      "$left" = "h";
      "$down" = "j";
      "$up" = "k";
      "$right" = "l";
      "$terminal" = "kitty";
      "$menu" = "$terminal --class fzflauncher ${../../../scripts/launcher/menu.sh}";

      # Monitor configuration
      monitor = [
        ",highrr,auto,1"
      ];

      xwayland = {
        force_zero_scaling = true;
      };

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
        gaps_out = "0, ${toString config.theme.spacing.s}, ${toString config.theme.spacing.s}, ${toString config.theme.spacing.s}";
        border_size = config.theme.borderWidth;
        layout = "dwindle";
        allow_tearing = false;

        "col.active_border" = lib.mkForce "rgb(${config.theme.colors.base03})";
        "col.inactive_border" = lib.mkForce "rgb(${config.theme.colors.base01})";
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
          range = 4;
          render_power = 3;
        };
      };

      animations = {
        enabled = true;
        bezier = [
          "wind, 0.05, 0.9, 0.1, 1.05"
          "winIn, 0.1, 1.1, 0.1, 1.1"
          "winOut, 0.3, -0.3, 0, 1"
          "liner, 1, 1, 1, 1"
        ];
        animation = [
          "windows, 1, 4, wind, slide"
          "windowsIn, 1, 4, winIn, slide"
          "windowsOut, 1, 3, winOut, slide"
          "windowsMove, 1, 3, wind, slide"
          "border, 1, 1, liner"
          "borderangle, 1, 13, liner, loop"
          "fade, 1, 8, default"
          "workspaces, 1, 3, wind"
        ];
      };

      # Group configuration
      group = {
        groupbar = {
          enabled = false;
          stacked = false;
        };
        "col.border_active" = lib.mkForce "rgb(${config.theme.colors.base03})";
        "col.border_inactive" = lib.mkForce "rgb(${config.theme.colors.base01})";
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
        "float, class:^(nemo)$"

        "float, class:^(fzflauncher)$" 
        "size 275 360, class:^(fzflauncher)$"
        "move 45% 4%, class:^(fzflauncher)$"
        "pin, class:^(fzflauncher)$"
        "stayfocused, class:^(fzflauncher)$"

        "float, class:^(float)$" 
        "size 800 600, class:^(float)$"
      ];

      layerrule = [
        "ignorealpha 0.0, notifications"
        "ignorealpha 0.4, waybar"
        "blur, waybar"
        "blur, notifications"
      ];

      # Key bindings
      bind = [
        # Basic bindings
        "$mod, F10, exec, $terminal"
        "$mod, Q, killactive"
        "ALT, SPACE, exec, $menu"
        "$mod CTRL, M, exec, $terminal --class float wiremix -v output"
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
        "$mod, COMMA, exec, bash ${../../../scripts/hypr-group.sh}"
        "$mod, j, changegroupactive, b"
        "$mod, k, changegroupactive, f"
        "$mod CTRL, F, fullscreen"
        "$mod, APOSTROPHE, exec, hyprctl --batch \"dispatch togglefloating; dispatch resizeactive exact 1000 800; dispatch centerwindow 1\""
        "$mod, SPACE, focusurgentorlast"

        # Scratchpad (special workspace)
        "$mod, BRACKETRIGHT, movetoworkspace, special"
        "$mod, BRACKETLEFT, togglespecialworkspace"
        "$mod, BACKSLASH, togglefloating"

        # Resizing
        "$mod, MINUS, resizeactive, -50 0"
        "$mod, EQUAL, resizeactive, 50 0"
        "$mod SHIFT, MINUS, resizeactive, 0 -50"
        "$mod SHIFT, EQUAL, resizeactive, 0 50"

        # Monitor movement
        "$mod SHIFT, RIGHT, movewindow, mon:+1"
        "$mod SHIFT, LEFT, movewindow, mon:-1"
        "$mod SHIFT, UP, movewindow, mon:+1"
        "$mod SHIFT, DOWN, movewindow, mon:-1"

        # Screenshots
        ", PRINT, exec, grim"
        "ALT SHIFT, 4, exec, grim -g \"$(slurp)\" ${config.home.homeDirectory}/Screenshots/$(date +'%Y-%m-%d-%H%M%S_screenshot.png')"
      ];

      # Mouse bindings
      bindm = [
        "$mod, mouse:272, movewindow"
        "$mod, mouse:273, resizewindow"
      ];

      # Media keys
      bindl = [
        ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle && ${config.home.homeDirectory}/dotfiles/scripts/volume-notify.sh"
        ", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 1%- && ${config.home.homeDirectory}/dotfiles/scripts/volume-notify.sh"
        ", XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 1%+ && ${config.home.homeDirectory}/dotfiles/scripts/volume-notify.sh"
        ", XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle && ${config.home.homeDirectory}/dotfiles/scripts/volume-notify.sh"
        ", XF86MonBrightnessDown, exec, brightnessctl set 5%- && ${config.home.homeDirectory}/dotfiles/scripts/brightness-notify.sh"
        ", XF86MonBrightnessUp, exec, brightnessctl set 5%+ && ${config.home.homeDirectory}/dotfiles/scripts/brightness-notify.sh"

        ", switch:on:Lid Switch, exec, hyprlock & systemctl suspend"
      ];

      # Mouse wheel workspace switching
      binde = [
        "$mod, mouse_down, workspace, e+1"
        "$mod, mouse_up, workspace, e-1"
      ];

      # Startup applications
      exec-once = [
        "hyprlock"
        "hyprctl dispatch workspace name:T"
        "waybar"
        "nm-applet"
        "blueman-applet"
        "wpctl set-volume @DEFAULT_AUDIO_SINK@ 50%"
      ];

      # Environment variables
      env = [
        "XCURSOR_THEME,capitaine-cursors"
        "XCURSOR_SIZE,16"
      ];
    };
  };
}
