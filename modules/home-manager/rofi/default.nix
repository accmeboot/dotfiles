{ config, pkgs, lib, ... }:
let
  customTheme = pkgs.writeText "custom.rasi" ''
    * {
      font: "SF Pro Text 12";
    }

    window {
      location: center;
      anchor: center;
      fullscreen: false;
      width: 600px;
      x-offset: 0px;
      y-offset: 0px;
      enabled: true;
      border-radius: ${toString config.theme.borderRadius}px;
      cursor: "default";
      background-color: ${config.theme.hexToRgba config.theme.colors.base00 config.theme.opacity};
      border-color: #${config.theme.colors.base05};
      border: ${toString config.theme.borderWidth}px;
    }

    /* Containers */

    mainbox {
      enabled: true;
      spacing: 0px;
      background-color: transparent;
      orientation: vertical;
      children: [ "inputbar", "listbox" ];
    }

    listbox {
      spacing: 20px;
      padding: 10px;
      background-color: transparent;
      orientation: vertical;
      children: [ "message", "listview" ];
    }

    inputbar {
      enabled: true;
      padding: 10px;
      background-color: transparent;
      text-color: #${config.theme.colors.base05};
      orientation: horizontal;
      children: [ "prompt", "entry" ];
      border: 0px 0px 1px 0px;
      border-color: #${config.theme.colors.base03};
    }

    /* Children */

    prompt {
      background-color: inherit;
      color: #${config.theme.colors.base0D};
      font: "SF Pro Text 28";
      margin: 0px 5px 0px 15px;
    }

    entry {
      enabled: true;
      expand: true;
      background-color: transparent;
      text-color: inherit;
      cursor: text;
      placeholder: "Search...";
      placeholder-color: #${config.theme.colors.base03};
      vertical-align: 0.5;
    }

    listview {
      enabled: true;
      cycle: true;
      lines: 4;
      dynamic: true;
      scrollbar: false;
      spacing: 10px;
      background-color: transparent;
      text-color: #${config.theme.colors.base05};
      cursor: "default";
    }

    element {
      enabled: true;
      spacing: 10px;
      padding: 10px;
      border-radius: ${toString config.theme.borderRadius}px;
      background-color: transparent;
      text-color: #${config.theme.colors.base05};
      cursor: pointer;
      orientation: horizontal;
    }

    element normal.normal {
      background-color: inherit;
      text-color: inherit;
    }

    element normal.urgent {
      background-color: ${config.theme.hexToRgba config.theme.colors.base09 config.theme.opacity};
      text-color: #${config.theme.colors.base05};
    }

    element normal.active {
      background-color: ${config.theme.hexToRgba config.theme.colors.base02 config.theme.opacity};
      text-color: #${config.theme.colors.base05};
    }

    element selected.normal {
      background-color: ${config.theme.hexToRgba config.theme.colors.base03 config.theme.opacity};
      text-color: #${config.theme.colors.base05};
    }

    element selected.urgent {
      background-color: ${config.theme.hexToRgba config.theme.colors.base09 config.theme.opacity};
      text-color: #${config.theme.colors.base05};
    }

    element selected.active {
      background-color: ${config.theme.hexToRgba config.theme.colors.base03 config.theme.opacity};
      text-color: #${config.theme.colors.base05};
    }

    element-icon {
      background-color: transparent;
      text-color: inherit;
      size: 42px;
      cursor: inherit;
    }

    element-text {
      background-color: transparent;
      text-color: inherit;
      cursor: inherit;
      vertical-align: 0.5;
      horizontal-align: 0.0;
    }

    message {
      background-color: transparent;
    }

    textbox {
      padding: 10px;
      border-radius: ${toString config.theme.borderRadius}px;
      background-color: ${config.theme.hexToRgba config.theme.colors.base02 config.theme.opacity};
      text-color: #${config.theme.colors.base04};
      vertical-align: 0.5;
      horizontal-align: 0.0;
    }

    error-message {
      padding: 10px;
      border-radius: ${toString config.theme.borderRadius}px;
      background-color: ${config.theme.hexToRgba config.theme.colors.base02 config.theme.opacity};
      text-color: #${config.theme.colors.base04};
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
      "display-window" = " ";
      "drun-display-format" = "{name}\r[<span weight='light' size='small' alpha='70%'><i>({comment})</i></span>]";
      "window-format" = "{w} · {c}";
      "kb-cancel" = "Escape,Control+g,Control+bracketleft,MouseSecondary";
    };
    package = pkgs.rofi-wayland.override {
      theme = customTheme;
    };
  };
}
