{ config, pkgs, lib, ... }:
let
  customTheme = pkgs.writeText "custom.rasi" ''
    * {
      font: "SF Pro Text 9.5";
    }

    window {
      location: northwest;
      anchor: northwest;
      fullscreen: false;
      width: 100%;
      x-offset: 0px;
      y-offset: -32px;
      height: 32px;
      enabled: true;
      cursor: "default";
      background-color: transparent;
      padding: 0px ${toString config.theme.spacing.s}px;
    }

    /* Containers */

    mainbox {
      enabled: true;
      background-color: transparent;
      orientation: horizontal;
      children: [ "inputbar", "listbox" ];
    }

    listbox {
      spacing: 20px;
      background-color: transparent;
      orientation: horizontal;
      children: [ "message", "listview" ];
      padding: 8px 0px;
    }

    inputbar {
      enabled: true;
      background-color: transparent;
      text-color: #${config.theme.colors.base05};
      orientation: horizontal;
      children: [ "prompt", "entry" ];
    }

    /* Children */

    prompt {
      background-color: #${config.theme.colors.base0D};
      color: #${config.theme.colors.base02};
      padding: 0px ${toString config.theme.spacing.s}px;
      margin: ${toString config.theme.spacing.xs}px 0px;
      border-radius: ${toString config.theme.borderRadius}px;
      vertical-align: 0.5;
      font: "SF Pro Text 14";
    }

    entry {
      background-color: transparent;
      text-color: inherit;
      cursor: text;
      placeholder: " Search...";
      placeholder-color: #${config.theme.colors.base04};
      vertical-align: 0.5;
      margin: 0px ${toString config.theme.spacing.xs}px;
    }

    listview {
      background-color: transparent;
      text-color: #${config.theme.colors.base05};
      layout: horizontal;
      spacing: 20px;
    }

    element {
      spacing: ${toString config.theme.spacing.xs}px;
      background-color: transparent;
      text-color: #${config.theme.colors.base05};
    }

    element normal.normal {
      background-color: inherit;
      text-color: inherit;
    }

    element normal.urgent {
      background-color: inherit;
      text-color: #${config.theme.colors.base08};
    }

    element normal.active {
      background-color: inherit;
      text-color: #${config.theme.colors.base0B};
    }

    element selected.normal {
      background-color: inherit;
      text-color: inherit;
      text-color: #${config.theme.colors.base0D};
    }

    element selected.urgent {
      background-color: inherit;
      text-color: #${config.theme.colors.base08};
    }

    element selected.active {
      background-color: inherit;
      text-color: #${config.theme.colors.base0D};
    }

    element-icon {
      background-color: transparent;
      text-color: inherit;
      size: 12px;
      cursor: inherit;
    }

    element-text {
      background-color: transparent;
      text-color: inherit;
      cursor: inherit;
      vertical-align: 0.5;
    }

    message {
      background-color: transparent;
    }

    textbox {
      border-radius: ${toString config.theme.borderRadius}px;
      background-color: #${config.theme.colors.base02};
      text-color: #${config.theme.colors.base04};
    }

    error-message {
      border-radius: ${toString config.theme.borderRadius}px;
      background-color: #${config.theme.colors.base02};
      text-color: #${config.theme.colors.base04};
    }
  '';
in {
  programs.rofi = {
    enable = true;
    extraConfig = {
      modi = "drun,window,powermenu:${../../../scripts/powermenu.sh}";
      show-icons = true;
      "display-drun" = "󰥭";
      "display-powermenu" = "󰤄";
      "display-window" = "󰖭";
      "drun-display-format" = "{name}";
      "window-format" = "{w} · {c}";
      "kb-cancel" = "Escape,Control+g,Control+bracketleft,MouseSecondary";
    };
    package = pkgs.rofi-wayland.override {
      theme = customTheme;
    };
  };
}
