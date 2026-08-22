{ config, pkgs, ... }:
let
  colors = config.lib.stylix.colors;
  font = config.stylix.fonts.serif.name;
in {
  home.packages = with pkgs; [ rofi ];

  home.file.".config/rofi/config.rasi".text = ''
    configuration {
      kb-cancel: "Escape,Control+g,Control+bracketleft,MouseSecondary";
      modi: "drun,window,run";
      window-format: "{t}";
      show-icons: false;
      terminal: "ghostty";
      display-drun: "Open:";
      display-dmenu: "Select:";
      display-window: "Windows:";
      display-run: "Run:";
    }

    * {
    	margin: 0px;
    	padding: 0px;
    	spacing: 0px;

    	background-color: transparent;
    	text-color: #${colors.base05};
      border: 0px;

      font: "${font}";
    }

    window {
    	location: north west;
      y-offset: -25px;
    	background-color: #${colors.base00};
      border-radius: 0px;
    	children: [ mainbox, message];
      border: none;
      border-color: #${colors.base03};
      padding: 0;
    }

    mainbox {
    	orientation: horizontal;
    	children: [ inputbar, listview];
    }

    inputbar {
      children: [ prompt, entry ];
      text-color: inherit;
      padding: 0;
      border: none;
    }

    message {
    	background-color: #${colors.base00};
    	text-color: #${colors.base05};
    }

    prompt {
      text-color: inherit;
    	background-color: inherit;
    	padding: 3px 2px;
    }

    entry {
      text-color: inherit;
      border: inherit;
      placeholder: "";
      width: 8%;
    	background-color: #${colors.base00};
    	padding: 3px 8px;
    }

    listview {
    	layout: horizontal;
      flow: horizontal;
      dynamic: true;
      cycle: true;
      border: inherit;
      padding: 0;
    }

    element {
    	padding: 3px 4px;
    	margin: 0px;
    	spacing: 4px;
    }

    element normal.normal {
    	text-color: inherit;
    	background-color: inherit;
    }

    element normal.urgent {
    	text-color: #${colors.base08};
    }

    element normal.active {
    	text-color: #${colors.base05};
    	background-color: #${colors.base03};
    }

    element selected {
    	text-color: #${colors.base00};
    }

    element selected.normal {
    	background-color: #${colors.base05};
    	text-color: #${colors.base00};
    }

    element selected.urgent {
    	background-color: #${colors.base08};
    }

    element selected.active {
    	text-color: #${colors.base00};
    	background-color: #${colors.base05};
    }

    element alternate.normal {
    	text-color: inherit;
    	background-color: inherit;
    }

    element alternate.urgent {
    	text-color: #${colors.base08};
    }

    element alternate.active {
    	text-color: #${colors.base05};
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
