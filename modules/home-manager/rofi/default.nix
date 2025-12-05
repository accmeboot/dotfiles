{ config, pkgs, ... }:
let
  theme = config.stylix.theme;
  colors = config.lib.stylix.colors;
in {
  home.packages = with pkgs; [ rofi ];

  home.file.".config/rofi/config.rasi".text = ''
    configuration {
      kb-cancel: "Escape,Control+g,Control+bracketleft,MouseSecondary";
      modi: "drun,menu:${../../../scripts/system-menu.sh}";
      show-icons: false;
      terminal: "wezterm";
    }

    * {
    	margin: 0px;
    	padding: 0px;
    	spacing: 0px;

    	background-color: transparent;
    	text-color: #${colors.base05};
      border: 0px;

      font: "serif";
    }

    window {
    	location: center;
    	width: 350px;
    	background-color: #${colors.base01};
      border-radius: ${toString theme.borderRadius};
    	children: [ mainbox, message];
      border: inherit;
      padding: 0;
    }

    mainbox {
    	orientation: vertical;
    	children: [ inputbar, listview];
    }

    inputbar {
      children: [entry];
      text-color: inherit;
      padding: 0;
      border: none;
    }

    message {
    	background-color: #${colors.base00};
    	text-color: #${colors.base05};
    }

    entry {
      text-color: inherit;
      border: inherit;
      placeholder: "";
    	background-color: #${colors.base00};
    	padding: ${toString theme.spacing.s}px ${toString theme.spacing.xs}px;
    }

    listview {
    	layout: vertical;
      border: inherit;
      scrollbar: false;
      fixed-height: false;
      dynamic: true;
      lines: 5;
      padding: 0;
    }

    element {
    	padding: ${toString theme.spacing.s}px ${
       toString (theme.spacing.xs + theme.borderWidth)
     }px;
    	margin: 0px;
    	spacing: ${toString theme.spacing.xs}px;
    }

    element normal.normal {
    	text-color: inherit;
    	background-color: inherit;
    }

    element normal.urgent {
    	text-color: #${colors.base08};
    }

    element normal.active {
    	text-color: #${colors.base0D};
    }

    element alternate.normal {
    	text-color: inherit;
    	background-color: inherit;
    }

    element alternate.active {
    	text-color: #${colors.base0D};
    }

    element selected {
    	text-color: #${colors.base00};
    }

    element selected.normal {
    	background-color: #${colors.base0D};
    	text-color: #${colors.base00};
    }

    element selected.urgent {
    	background-color: #${colors.base08};
    }

    element selected.active {
    	background-color: #${colors.base03};
    }

    element-text {
      background-color: inherit;
      text-color: inherit;
    }

    element-icon {
      size: 18px;
    }
  '';
}
