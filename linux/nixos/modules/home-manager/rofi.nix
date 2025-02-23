{ config, pkgs, lib, ... }:
let
  rofi_bg = pkgs.copyPathToStore ../../../../assets/rofi_bg.png;
  customTheme = pkgs.writeText "custom.rasi" ''
    * {
      font: "System-ui Regular 12";
      background: #${config.lib.stylix.colors.base00};
      background-alt: #${config.lib.stylix.colors.base01};
      foreground: #${config.lib.stylix.colors.base05};
      selected: #${config.lib.stylix.colors.base0D};
      active: #${config.lib.stylix.colors.base0B};
      urgent: #${config.lib.stylix.colors.base08};
    }

    window {
      transparency: "real";
      location: center;
      anchor: center;
      fullscreen: false;
      width: 800px;
      x-offset: 0px;
      y-offset: 0px;
      enabled: true;
      border-radius: 4px;
      cursor: "default";
      background-color: @background;
      border-color: @foreground;
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
      spacing: 10px;
      padding: 100px 60px;
      background-color: transparent;
      background-image: url("${rofi_bg}", width);
      text-color: @foreground;
      orientation: horizontal;
      children: [ "textbox-prompt-colon", "entry", "dummy", "mode-switcher" ];
    }

    textbox-prompt-colon {
      enabled: true;
      expand: false;
      str: " ";
      padding: 12px 10px 12px 15px;
      border-radius: 4px;
      background-color: @background-alt;
      text-color: inherit;
    }

    entry {
      enabled: true;
      expand: false;
      width: 450px;
      padding: 12px 16px;
      border-radius: 4px;
      background-color: @background-alt;
      text-color: inherit;
      cursor: text;
      placeholder: "Search";
      placeholder-color: inherit;
    }

    dummy {
      expand: true;
      background-color: transparent;
    }

    mode-switcher {
      enabled: true;
      spacing: 10px;
      background-color: transparent;
      text-color: @foreground;
    }

    button {
      width: 50px;
      padding: 12px 8px 12px 12px;
      border-radius: 4px;
      background-color: @background-alt;
      text-color: inherit;
      cursor: pointer;
    }

    button selected {
      background-color: @selected;
      text-color: @background;
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
      text-color: @foreground;
      cursor: "default";
    }

    element {
      enabled: true;
      spacing: 10px;
      padding: 10px;
      border-radius: 4px;
      background-color: transparent;
      text-color: @foreground;
      cursor: pointer;
      orientation: vertical;
    }

    element normal.normal {
      background-color: inherit;
      text-color: inherit;
    }

    element normal.urgent {
      background-color: @urgent;
      text-color: @foreground;
    }

    element normal.active {
      background-color: @active;
      text-color: @foreground;
    }

    element selected.normal {
      background-color: @selected;
      text-color: @background;
    }

    element selected.urgent {
      background-color: @urgent;
      text-color: @background;
    }

    element selected.active {
      background-color: @urgent;
      text-color: @background;
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
      border-radius: 4px;
      background-color: @background-alt;
      text-color: @foreground;
      vertical-align: 0.5;
      horizontal-align: 0.0;
    }

    error-message {
      padding: 15px;
      border-radius: 4px;
      background-color: @background;
      text-color: @foreground;
    }
  '';
in {
  programs.rofi = {
    enable = true;
    extraConfig = {
      modi = "drun,window,powermenu:${../../scripts/powermenu.sh}";
      show-icons = true;
      "display-drun" = " ";
      "display-powermenu" = " ";
      "display-window" = " ";
      "drun-display-format" = "{name}";
      "window-format" = "{w} · {c}";
      "kb-cancel" = "Escape,Control+g,Control+bracketleft,MouseSecondary";
    };
    package = pkgs.rofi.override {
      theme = customTheme;
    };
  };
}
