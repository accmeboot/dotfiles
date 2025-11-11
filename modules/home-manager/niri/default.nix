{ config, ... }: {
  home.file.".config/niri/config.kdl".text = ''
    input {
        keyboard {
            xkb {
                layout "us,ru"
                options "grp:ctrl_space_toggle"
            }
            numlock
        }
        touchpad {
            tap
            natural-scroll
        }
        mouse {
            accel-speed 0.0
            accel-profile "flat"
            scroll-method "no-scroll"
        }
        warp-mouse-to-focus
        focus-follows-mouse max-scroll-amount="0%"
    }

    output "DP-2" {
        mode "2560x1440@239.970"
        scale 1
        variable-refresh-rate
        transform "normal"
    }

    layout {
        gaps ${toString config.theme.spacing.s}
        background-color "transparent"
        center-focused-column "never"

        preset-column-widths {
            proportion 0.33333
            proportion 0.5
        }

        default-column-width { proportion 0.5; }
        focus-ring {
            off
        }
        border {
            width ${toString config.theme.borderWidth}
            active-color "#${config.theme.colors.base0D}"
            inactive-color "#${config.theme.colors.base03}"
            urgent-color "#${config.theme.colors.base08}"
        }
        shadow {
            on
            softness 1
            spread 2
            offset x=4 y=4
            draw-behind-window true
            color "#1B161099"
        }
    }

    spawn-at-startup "waybar"
    spawn-sh-at-startup "sleep 0.5 && pkill nm-applet"
    spawn-sh-at-startup "sleep 0.5 && hyprlock"

    hotkey-overlay {
        skip-at-startup
    }

    // Uncomment this line to ask the clients to omit their client-side decorations if possible.
    // This option will also fix border/focus ring drawing behind some semitransparent windows.
    prefer-no-csd

    screenshot-path "~/Pictures/Screenshots/%Y-%m-%d %H-%M-%S_screenshot.png"

    animations {
        // Uncomment to turn off all animations.
        // off

        // Slow down all animations by this factor. Values below 1 speed them up instead.
        // slowdown 3.0
    }

    layer-rule {
        match namespace="waybar"
        match namespace="^notifications$"

        match at-startup=true

        shadow {
            on
            softness 1
            spread 2
            offset x=4 y=4
            draw-behind-window true
            color "#1B161099"
        }

        place-within-backdrop true
    }

    layer-rule {
      match namespace="^notifications$"
      geometry-corner-radius ${toString config.theme.borderRadius}
    }

    // Make the wallpaper stationary, rather than moving with workspaces.
    layer-rule {
        // Find the right namespace by running niri msg layers.
        match namespace="^hyprpaper$"
        place-within-backdrop true
    }

    window-rule {
        match app-id=r#"^org\.wezfurlong\.wezterm$"#
        default-column-width {}
    }

    window-rule {
        match app-id=r#"^com\.accme\.float$"#
        open-floating true
    }

    window-rule {
        geometry-corner-radius ${toString config.theme.borderRadius}
        clip-to-geometry true
    }

    binds {
        Mod+Shift+Slash { show-hotkey-overlay; }

        Mod+T hotkey-overlay-title="Open a Terminal: wezterm" { spawn "wezterm"; }
        Mod+D hotkey-overlay-title="Run an Application: rofi" { spawn "rofi" "-show" "menu"; }
        Super+Alt+L hotkey-overlay-title="Lock the Screen: hyprlock" { spawn "hyprlock"; }

        XF86AudioRaiseVolume allow-when-locked=true { spawn-sh "wpctl set-volume @DEFAULT_AUDIO_SINK@ 2%+"; }
        XF86AudioLowerVolume allow-when-locked=true { spawn-sh "wpctl set-volume @DEFAULT_AUDIO_SINK@ 2%-"; }
        XF86AudioMute        allow-when-locked=true { spawn-sh "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"; }
        XF86AudioMicMute     allow-when-locked=true { spawn-sh "wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"; }
        XF86MonBrightnessUp allow-when-locked=true { spawn "brightnessctl" "--class=backlight" "set" "+5%"; }
        XF86MonBrightnessDown allow-when-locked=true { spawn "brightnessctl" "--class=backlight" "set" "5%-"; }

        Mod+O repeat=false { toggle-overview; }

        Mod+Q repeat=false { close-window; }

        Mod+H     { focus-column-left; }
        Mod+J     { focus-window-down; }
        Mod+K     { focus-window-up; }
        Mod+L     { focus-column-right; }

        Mod+Shift+H     { move-column-left; }
        Mod+Shift+J     { move-window-down; }
        Mod+Shift+K     { move-window-up; }
        Mod+Shift+L     { move-column-right; }

        Mod+Ctrl+H     { focus-monitor-left; }
        Mod+Ctrl+J     { focus-monitor-down; }
        Mod+Ctrl+K     { focus-monitor-up; }
        Mod+Ctrl+L     { focus-monitor-right; }

        Mod+Shift+Ctrl+H     { move-window-to-monitor-left; }
        Mod+Shift+Ctrl+J     { move-window-to-monitor-down; }
        Mod+Shift+Ctrl+K     { move-window-to-monitor-up; }
        Mod+Shift+Ctrl+L     { move-window-to-monitor-right; }

        Mod+U              { focus-workspace-down; }
        Mod+I              { focus-workspace-up; }
        Mod+Ctrl+U         { move-column-to-workspace-down; }
        Mod+Ctrl+I         { move-column-to-workspace-up; }

        Mod+Shift+U         { move-workspace-down; }
        Mod+Shift+I         { move-workspace-up; }

        Mod+WheelScrollDown      cooldown-ms=150 { focus-workspace-down; }
        Mod+WheelScrollUp        cooldown-ms=150 { focus-workspace-up; }
        Mod+Ctrl+WheelScrollDown cooldown-ms=150 { move-column-to-workspace-down; }
        Mod+Ctrl+WheelScrollUp   cooldown-ms=150 { move-column-to-workspace-up; }

        Mod+WheelScrollRight      { focus-column-right; }
        Mod+WheelScrollLeft       { focus-column-left; }
        Mod+Ctrl+WheelScrollRight { move-column-right; }
        Mod+Ctrl+WheelScrollLeft  { move-column-left; }

        Mod+Shift+WheelScrollDown      { focus-column-right; }
        Mod+Shift+WheelScrollUp        { focus-column-left; }
        Mod+Ctrl+Shift+WheelScrollDown { move-column-right; }
        Mod+Ctrl+Shift+WheelScrollUp   { move-column-left; }

        Mod+1 { focus-workspace 1; }
        Mod+2 { focus-workspace 2; }
        Mod+3 { focus-workspace 3; }
        Mod+4 { focus-workspace 4; }
        Mod+5 { focus-workspace 5; }
        Mod+6 { focus-workspace 6; }
        Mod+7 { focus-workspace 7; }
        Mod+8 { focus-workspace 8; }
        Mod+9 { focus-workspace 9; }

        Mod+Shift+1 { move-column-to-workspace 1; }
        Mod+Shift+2 { move-column-to-workspace 2; }
        Mod+Shift+3 { move-column-to-workspace 3; }
        Mod+Shift+4 { move-column-to-workspace 4; }
        Mod+Shift+5 { move-column-to-workspace 5; }
        Mod+Shift+6 { move-column-to-workspace 6; }
        Mod+Shift+7 { move-column-to-workspace 7; }
        Mod+Shift+8 { move-column-to-workspace 8; }
        Mod+Shift+9 { move-column-to-workspace 9; }

        // Switches focus between the current and the previous workspace.
        Mod+Tab { focus-window-previous; }

        Mod+BracketLeft  { consume-or-expel-window-left; }
        Mod+BracketRight { consume-or-expel-window-right; }
        Mod+Comma  { consume-window-into-column; }
        Mod+Period { expel-window-from-column; }
        Mod+R { switch-preset-column-width; }
        Mod+Shift+R { switch-preset-window-height; }
        Mod+Ctrl+R { reset-window-height; }
        Mod+F { maximize-column; }
        Mod+Shift+F { fullscreen-window; }
        Mod+Ctrl+F { expand-column-to-available-width; }
        Mod+C { center-column; }
        Mod+Ctrl+C { center-visible-columns; }

        Mod+Minus { set-column-width "-10%"; }
        Mod+Equal { set-column-width "+10%"; }

        Mod+Shift+Minus { set-window-height "-10%"; }
        Mod+Shift+Equal { set-window-height "+10%"; }

        Mod+V       { toggle-window-floating; }
        Mod+Shift+V { switch-focus-between-floating-and-tiling; }

        Mod+W { toggle-column-tabbed-display; }

        Print { screenshot-screen; }
        Shift+Alt+4 { screenshot; }
        Alt+Print { screenshot-window; }

        Mod+Escape allow-inhibiting=false { toggle-keyboard-shortcuts-inhibit; }

        Mod+Shift+E { quit; }
        Ctrl+Alt+Delete { quit; }

        Mod+Shift+P { power-off-monitors; }
    }
  '';
}
