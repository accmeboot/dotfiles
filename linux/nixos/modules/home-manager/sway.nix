{ config, pkgs, lib, ... }:
{
  wayland.windowManager.sway = {
    enable = true;
    config = {
      # Variables
      modifier = "Mod4";
      left = "h";
      down = "j";
      up = "k";
      right = "l";
      terminal = "kitty";
      menu = "rofi";

      bars = [];

      # Output configuration
      output = {
        "*" = {
          adaptive_sync = "on";
        };
        "DP-2" = {
          resolution = "1920x1080@360Hz";
        };
      };

      # Input configuration
      input = {
        "*" = {
          accel_profile = "flat";
          pointer_accel = "0";
        };
      };

      # Key bindings
      keybindings = let
        modifier = config.wayland.windowManager.sway.config.modifier;
      in {
        # Mouse bindings
        "--whole-window ${modifier}+button4" = "workspace prev";
        "--whole-window ${modifier}+button5" = "workspace next";
        "button2" = "kill";

        # Basic bindings
        "${modifier}+f10" = "exec ${config.wayland.windowManager.sway.config.terminal}";
        "${modifier}+Backspace" = "kill";
        "alt+space" = "exec ${config.wayland.windowManager.sway.config.menu} -show drun";
        "${modifier}+Return" = "exec ${config.wayland.windowManager.sway.config.menu} -show powermenu";
        "${modifier}+f11" = "reload";
        "${modifier}+Tab" = "workspace back_and_forth";
        
        # Movement
        "${modifier}+${config.wayland.windowManager.sway.config.left}" = "focus left";
        "${modifier}+${config.wayland.windowManager.sway.config.down}" = "focus down";
        "${modifier}+${config.wayland.windowManager.sway.config.up}" = "focus up";
        "${modifier}+${config.wayland.windowManager.sway.config.right}" = "focus right";

        "${modifier}+Shift+${config.wayland.windowManager.sway.config.left}" = "move left";
        "${modifier}+Shift+${config.wayland.windowManager.sway.config.down}" = "move down";
        "${modifier}+Shift+${config.wayland.windowManager.sway.config.up}" = "move up";
        "${modifier}+Shift+${config.wayland.windowManager.sway.config.right}" = "move right";

        # Workspaces
        "${modifier}+1" = "workspace number 1";
        "${modifier}+2" = "workspace number 2";
        "${modifier}+3" = "workspace number 3";
        "${modifier}+4" = "workspace number 4";
        "${modifier}+5" = "workspace number 5";
        "${modifier}+6" = "workspace number 6";
        "${modifier}+7" = "workspace number 7";
        "${modifier}+8" = "workspace number 8";
        "${modifier}+9" = "workspace number 9";
        "${modifier}+a" = "workspace A";
        "${modifier}+b" = "workspace B";
        "${modifier}+c" = "workspace C";
        "${modifier}+d" = "workspace D";
        "${modifier}+e" = "workspace E";
        "${modifier}+f" = "workspace F";
        "${modifier}+g" = "workspace G";
        "${modifier}+i" = "workspace I";
        "${modifier}+m" = "workspace M";
        "${modifier}+n" = "workspace N";
        "${modifier}+o" = "workspace O";
        "${modifier}+p" = "workspace P";
        "${modifier}+q" = "workspace Q";
        "${modifier}+r" = "workspace R";
        "${modifier}+s" = "workspace S";
        "${modifier}+t" = "workspace T";
        "${modifier}+u" = "workspace U";
        "${modifier}+v" = "workspace V";
        "${modifier}+w" = "workspace W";
        "${modifier}+x" = "workspace X";
        "${modifier}+y" = "workspace Y";
        "${modifier}+z" = "workspace Z";

        # Move container to workspace
        "${modifier}+Shift+1" = "move container to workspace number 1";
        "${modifier}+Shift+2" = "move container to workspace number 2";
        "${modifier}+Shift+3" = "move container to workspace number 3";
        "${modifier}+Shift+4" = "move container to workspace number 4";
        "${modifier}+Shift+5" = "move container to workspace number 5";
        "${modifier}+Shift+6" = "move container to workspace number 6";
        "${modifier}+Shift+7" = "move container to workspace number 7";
        "${modifier}+Shift+8" = "move container to workspace number 8";
        "${modifier}+Shift+9" = "move container to workspace number 9";
        "${modifier}+Shift+a" = "move container to workspace A";
        "${modifier}+Shift+b" = "move container to workspace B";
        "${modifier}+Shift+c" = "move container to workspace C";
        "${modifier}+Shift+d" = "move container to workspace D";
        "${modifier}+Shift+e" = "move container to workspace E";
        "${modifier}+Shift+f" = "move container to workspace F";
        "${modifier}+Shift+g" = "move container to workspace G";
        "${modifier}+Shift+i" = "move container to workspace I";
        "${modifier}+Shift+m" = "move container to workspace M";
        "${modifier}+Shift+n" = "move container to workspace N";
        "${modifier}+Shift+o" = "move container to workspace O";
        "${modifier}+Shift+p" = "move container to workspace P";
        "${modifier}+Shift+q" = "move container to workspace Q";
        "${modifier}+Shift+r" = "move container to workspace R";
        "${modifier}+Shift+s" = "move container to workspace S";
        "${modifier}+Shift+t" = "move container to workspace T";
        "${modifier}+Shift+u" = "move container to workspace U";
        "${modifier}+Shift+v" = "move container to workspace V";
        "${modifier}+Shift+w" = "move container to workspace W";
        "${modifier}+Shift+x" = "move container to workspace X";
        "${modifier}+Shift+y" = "move container to workspace Y";
        "${modifier}+Shift+z" = "move container to workspace Z";

        # Layout bindings
        "${modifier}+slash" = "layout toggle split";
        "${modifier}+comma" = "layout stacking";
        "${modifier}+ctrl+f" = "fullscreen";
        "${modifier}+apostrophe" = "floating toggle";
        "${modifier}+space" = "focus mode_toggle";

        # Scratchpad
        "${modifier}+bracketright" = "move scratchpad";
        "${modifier}+bracketleft" = "scratchpad show";
        "${modifier}+backslash" = "floating disable";

        # Resizing
        "${modifier}+minus" = "resize shrink width 50px";
        "${modifier}+equal" = "resize grow width 50px";

        # Monitor movement
        "${modifier}+Shift+Right" = "move container to output right";
        "${modifier}+Shift+Left" = "move container to output left";
        "${modifier}+Shift+Up" = "move container to output up";
        "${modifier}+Shift+Down" = "move container to output down";

        # Media keys
        "--locked XF86AudioMute" = "exec wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
        "--locked XF86AudioLowerVolume" = "exec wpctl set-volume @DEFAULT_AUDIO_SINK@ 1%- && ${config.home.homeDirectory}/dotfiles/linux/nixos/scripts/volume-notify.sh";
        "--locked XF86AudioRaiseVolume" = "exec wpctl set-volume @DEFAULT_AUDIO_SINK@ 1%+ && ${config.home.homeDirectory}/dotfiles/linux/nixos/scripts/volume-notify.sh";
        "--locked XF86AudioMicMute" = "exec wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle";
        "--locked XF86MonBrightnessDown" = "exec brightnessctl set 5%-";
        "--locked XF86MonBrightnessUp" = "exec brightnessctl set 5%+";
        "Print" = "exec grim";
        "Mod1+Shift+4" = "exec grim -g \"$(slurp)\" ${config.home.homeDirectory}/$(date +'%Y-%m-%d-%H%M%S_screenshot.png')";
      };

      # Colors
      colors = {
        focused = {
          border = lib.mkForce "#${config.lib.stylix.colors.base0D}";
          background = lib.mkForce "#${config.lib.stylix.colors.base0D}";
          text = lib.mkForce "#${config.lib.stylix.colors.base01}";
          indicator = lib.mkForce "#${config.lib.stylix.colors.base0D}";
          childBorder = lib.mkForce "#${config.lib.stylix.colors.base0D}";
        };
        focusedInactive = {
          border = lib.mkForce "#${config.lib.stylix.colors.base03}";
          background = lib.mkForce "#${config.lib.stylix.colors.base03}";
          text = lib.mkForce "#${config.lib.stylix.colors.base05}";
          indicator = lib.mkForce "#${config.lib.stylix.colors.base03}";
          childBorder = lib.mkForce "#${config.lib.stylix.colors.base03}";
        };
        unfocused = {
          border = lib.mkForce "#${config.lib.stylix.colors.base03}";
          background = lib.mkForce "#${config.lib.stylix.colors.base03}";
          text = lib.mkForce "#${config.lib.stylix.colors.base05}";
          indicator = lib.mkForce "#${config.lib.stylix.colors.base03}";
          childBorder = lib.mkForce "#${config.lib.stylix.colors.base03}";
        };
        urgent = {
          border = lib.mkForce "#${config.lib.stylix.colors.base08}";
          background = lib.mkForce "#${config.lib.stylix.colors.base08}";
          text = lib.mkForce "#${config.lib.stylix.colors.base05}";
          indicator = lib.mkForce "#${config.lib.stylix.colors.base08}";
          childBorder = lib.mkForce "#${config.lib.stylix.colors.base08}";
        };
      };
      #
      # Gaps
      gaps = {
        inner = 4;
        outer = 4;
      };

      # Window rules
      floating = {
        criteria = [
          { app_id = "org.pulseaudio.pavucontrol"; }
          { app_id = "nemo"; }
        ];
      };

      # Workspace assignments
      assigns = {
        "B" = [{ class = "Brave-browser"; }];
        "T" = [{ class = "kitty"; }];
      };

      # Seat configuration
      seat = {
        "seat0" = {
          xcursor_theme = "capitaine-cursors 16";
        };
      };

      # Startup applications
      startup = [
        { command = "swaymsg \"workspace T\""; }
        { command = "blueman-applet"; }
        { command = "nm-applet"; }
        { command = "eww daemon --restart && eww open bar"; }
        { command = "sleep 5; systemctl --user start kanshi.service"; }
        { command = ''
          swayidle -w \
            timeout 300 'swaylock -f -c 000000' \
            timeout 600 'swaymsg "output * power off"' resume 'swaymsg "output * power on"' \
            timeout 900 'systemctl suspend' \
            before-sleep 'swaylock -f -c 000000'
        ''; }
      ];
    };

    # Enable sway system configuration
    wrapperFeatures.gtk = true;
  };
}
