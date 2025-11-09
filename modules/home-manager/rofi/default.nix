{ config, pkgs, ... }:
let
  customTheme = pkgs.writeText "custom.rasi" ''
    * {
    	font: "Inter 12";
    	margin: 0px;
    	padding: 0px;
    	spacing: 0px;

    	background-color: transparent;
    	text-color: #${config.theme.colors.base05};
    	accnet-color: #${config.theme.colors.base0D};
    }

    window {
    	location: north;
    	width: 700px;
    	background-color: #${config.theme.colors.base00};
    	children: [ mainbox, message];
    	y-offset: -36px;
    }

    mainbox {
    	orientation: horizontal;
    	children: [ inputbar, listview];
    }

    inputbar {
    	width: 5%;
    	padding: ${toString config.theme.spacing.xs}px ${
       toString config.theme.spacing.s
     }px;
      spacing: ${toString config.theme.spacing.s}px;
      children: [ prompt, entry];
    }

    prompt {
    	text-color: #${config.theme.colors.base0D};
    }

    listview {
    	layout: horizontal;
    }

    element {
    	padding: 0px ${toString config.theme.spacing.s}px;
    	margin: ${toString config.theme.spacing.xs}px 0px;
    	spacing: ${toString config.theme.spacing.xs}px;
    	border-radius: ${toString config.theme.borderRadius}px;
    }

    element normal urgent {
    	text-color: #${config.theme.colors.base08};
    }

    element normal active {
    	text-color: #${config.theme.colors.base0D};
    }

    element alternate active {
    	text-color: #${config.theme.colors.base0D};
    }

    element selected {
    	text-color: #${config.theme.colors.base00};
    }

    element selected normal {
    	background-color: #${config.theme.colors.base0D};
    }

    element selected urgent {
    	background-color: #${config.theme.colors.base08};
    }

    element selected active {
    	background-color: #${config.theme.colors.base03};
    }

    element-text {
    	text-color: inherit;
    }
  '';
in {
  programs.rofi = {
    enable = true;
    terminal = "wezterm";
    extraConfig = {
      modi = "drun,window,menu:${../../../scripts/system-menu.sh},run";
      show-icons = true;

      "display-drun" = "Apps:";
      "display-run" = "Run:";
      "display-window" = "Window:";
      "display-menu" = "Menu:";

      "kb-cancel" = "Escape,Control+g,Control+bracketleft,MouseSecondary";
    };
    package = pkgs.rofi.override { theme = customTheme; };
  };
}
