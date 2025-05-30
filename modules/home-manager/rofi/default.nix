{ config, pkgs, lib, ... }:
let
  rofi_bg = ../../../assets/wallpapers/wallhaven-2e2xyx.jpg;
  
  # Function to convert hex color to rgba with specified opacity
  hexToRgba = hexColor: opacity: 
    let
      hexToDecimal = hex: 
        let
          chars = builtins.listToAttrs [
            { name = "0"; value = 0; } { name = "1"; value = 1; } { name = "2"; value = 2; } { name = "3"; value = 3; }
            { name = "4"; value = 4; } { name = "5"; value = 5; } { name = "6"; value = 6; } { name = "7"; value = 7; }
            { name = "8"; value = 8; } { name = "9"; value = 9; } { name = "a"; value = 10; } { name = "b"; value = 11; }
            { name = "c"; value = 12; } { name = "d"; value = 13; } { name = "e"; value = 14; } { name = "f"; value = 15; }
            { name = "A"; value = 10; } { name = "B"; value = 11; } { name = "C"; value = 12; } { name = "D"; value = 13; }
            { name = "E"; value = 14; } { name = "F"; value = 15; }
          ];
          char1 = builtins.substring 0 1 hex;
          char2 = builtins.substring 1 1 hex;
        in
          chars.${char1} * 16 + chars.${char2};
      
      r = hexToDecimal (builtins.substring 0 2 hexColor);
      g = hexToDecimal (builtins.substring 2 2 hexColor);
      b = hexToDecimal (builtins.substring 4 2 hexColor);
    in
      "rgba(${toString r}, ${toString g}, ${toString b}, ${toString opacity})";
  
  customTheme = pkgs.writeText "custom.rasi" ''
    * {
      font: "SF Pro Text 12";
    }

    window {
      location: center;
      anchor: center;
      fullscreen: false;
      width: 800px;
      x-offset: 0px;
      y-offset: 0px;
      enabled: true;
      border-radius: 8px;
      cursor: "default";
      background-color: ${hexToRgba config.lib.stylix.colors.base00 0.8};
      border-color: #${config.lib.stylix.colors.base05};
      border: 2px;
    }

    mainbox {
      enabled: true;
      spacing: 0px;
      background-color: transparent;
      orientation: vertical;
      children: [ "inputbar", "listbox" ];
    }

    listbox {
      spacing: 20px;
      padding: 20px;
      background-color: transparent;
      orientation: vertical;
      children: [ "message", "listview" ];
    }

    inputbar {
      enabled: true;
      padding: 20px;
      background-color: ${hexToRgba config.lib.stylix.colors.base02 0.8};
      text-color: #${config.lib.stylix.colors.base05};
      orientation: horizontal;
      children: [ "textbox-prompt-colon", "entry", "mode-switcher" ];
    }

    textbox-prompt-colon {
      enabled: true;
      expand: false;
      str: " ";
      padding: 12px 5px 12px 0px;
      background-color: transparent;
      text-color: inherit;
      font: "SF Pro Text 16";
    }

    entry {
      enabled: true;
      expand: true;
      padding: 12px 16px 12px 0px;
      background-color: transparent;
      text-color: inherit;
      cursor: text;
      placeholder: "Search...";
      placeholder-color: inherit;
      font: "SF Pro Text 16";
    }

    mode-switcher {
      enabled: true;
      spacing: 20px;
      background-color: transparent;
      text-color: #${config.lib.stylix.colors.base05};
    }

    button {
      background-color: transparent;
      text-color: inherit;
      cursor: pointer;
      font: "SF Pro Text 18";
    }

    button selected {
      background-color: transparent;
      text-color: #${config.lib.stylix.colors.base0B};
    }

    listview {
      enabled: true;
      columns: 5;
      lines: 4;
      cycle: true;
      dynamic: true;
      scrollbar: false;
      layout: vertical;
      reverse: false;
      fixed-height: true;
      fixed-columns: true;
      flow: horizontal;
      spacing: 10px;
      background-color: transparent;
      text-color: #${config.lib.stylix.colors.base05};
      cursor: "default";
    }

    element {
      enabled: true;
      spacing: 10px;
      padding: 10px;
      border-radius: 8px;
      background-color: transparent;
      text-color: #${config.lib.stylix.colors.base05};
      cursor: pointer;
      orientation: vertical;
    }

    element normal.normal {
      background-color: inherit;
      text-color: inherit;
    }

    element normal.urgent {
      background-color: ${hexToRgba config.lib.stylix.colors.base09 0.8};
      text-color: #${config.lib.stylix.colors.base05};
    }

    element normal.active {
      background-color: ${hexToRgba config.lib.stylix.colors.base02 0.8};
      text-color: #${config.lib.stylix.colors.base05};
    }

    element selected.normal {
      background-color: ${hexToRgba config.lib.stylix.colors.base03 0.8};
      text-color: #${config.lib.stylix.colors.base05};
    }

    element selected.urgent {
      background-color: ${hexToRgba config.lib.stylix.colors.base09 0.8};
      text-color: #${config.lib.stylix.colors.base05};
    }

    element selected.active {
      background-color: ${hexToRgba config.lib.stylix.colors.base03 0.8};
      text-color: #${config.lib.stylix.colors.base05};
    }

    element-icon {
      background-color: transparent;
      text-color: inherit;
      size: 64px;
      cursor: inherit;
    }

    element-text {
      background-color: transparent;
      text-color: inherit;
      cursor: inherit;
      vertical-align: 0.5;
      horizontal-align: 0.5;
    }

    message {
      background-color: transparent;
    }

    textbox {
      padding: 15px;
      border-radius: 8px;
      background-color: ${hexToRgba config.lib.stylix.colors.base02 0.8};
      text-color: #${config.lib.stylix.colors.base04};
      vertical-align: 0.5;
      horizontal-align: 0.0;
    }

    error-message {
      padding: 15px;
      border-radius: 8px;
      background-color: ${hexToRgba config.lib.stylix.colors.base02 0.8};
      text-color: #${config.lib.stylix.colors.base04};
    }
  '';
in {
  programs.rofi = {
    enable = true;
    extraConfig = {
      modi = "drun,window,powermenu:${../../../scripts/powermenu.sh}";
      show-icons = true;
      "display-drun" = " ";
      "display-powermenu" = " ";
      "display-window" = " ";
      "drun-display-format" = "{name}";
      "window-format" = "{w} · {c}";
      "kb-cancel" = "Escape,Control+g,Control+bracketleft,MouseSecondary";
    };
    package = pkgs.rofi-wayland.override {
      theme = customTheme;
    };
  };
}
