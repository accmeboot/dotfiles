{ config, pkgs, lib, ... }:
let
  customTheme = pkgs.writeText "custom.rasi" ''
    * {
      font: "DepartureMono Nerd Font 24";
    }


    window {
      location: center;
      anchor: center;
      fullscreen: true;
      x-offset: 0px;
      y-offset: 0px;
      enabled: true;
      cursor: "default";
      background-color: #${config.theme.colors.base00}CC;
      padding: 35% 0px 0px 30%;
    }

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
    }

    inputbar {
      enabled: true;
      background-color: transparent;
      text-color: #${config.theme.colors.base05};
      orientation: horizontal;
      children: [ "prompt", "entry" ];
    }

    prompt {
      background-color: transparent;
      color: #${config.theme.colors.base07};
      padding: 0px ${toString config.theme.spacing.s}px;
    }

    entry {
      background-color: transparent;
      text-color: inherit;
      cursor: text;
      placeholder: "Search...";
      placeholder-color: #${config.theme.colors.base03};
      margin: 0px ${toString config.theme.spacing.xs}px;
    }

    listview {
      background-color: transparent;
      text-color: #${config.theme.colors.base05};
      layout: vertical;
      spacing: 20px;
    }

    element {
      spacing: ${toString config.theme.spacing.xs}px;
      background-color: transparent;
      text-color: #${config.theme.colors.base05};
      cursor: pointer;
      border-color: transparent;
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
      text-color: #${config.theme.colors.base05};
    }

    element selected.normal {
      background-color: inherit;
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

    element-text {
      background-color: transparent;
      text-color: inherit;
      cursor: inherit;
      vertical-align: 0.5;
    }

    element-icon {
      enabled: false;
      background-color: transparent;
      text-color: inherit;
      size: 12px;
      cursor: inherit;
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
      modi = "drun,combi,powermenu:${../../../scripts/powermenu.sh}";
      show-icons = true;
      "display-drun" = "->";
      "display-powermenu" = "<-";
      "display-combi" = "-$";
      "display-window" = "*";

      "drun-display-format" = "{name}";
      "window-format" = "{w}{c}";
      "kb-cancel" = "Escape,Control+g,Control+bracketleft,MouseSecondary";
    };
    package = pkgs.rofi-wayland.override {
      theme = customTheme;
    };
  };
}
