{ config, pkgs, ... }: {
  home.packages = with pkgs; [ rofi ];

  home.file.".config/rofi/config.rasi".text = ''
    configuration {
      display-drun: "Apps:";
      display-menu: "Menu:";

      kb-cancel: "Escape,Control+g,Control+bracketleft,MouseSecondary";

      modi: "drun,menu:${../../../scripts/system-menu.sh}";

      show-icons: false;

      terminal: "wezterm";
    }

    * {
    	font: "Inter 12";
    	margin: 0px;
    	padding: 0px;
    	spacing: 0px;

    	background-color: transparent;
    	text-color: #${config.theme.colors.base05};
      border: 0px;
    }

    window {
    	location: north;
    	width: 700px;
    	background-color: #${config.theme.colors.base00};
    	children: [ mainbox, message];
    	y-offset: -30px;
      border: inherit;
      padding: 0;
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
      text-color: inherit;
    }

    prompt {
    	text-color: #${config.theme.colors.base0D};
    	border-radius: ${toString config.theme.borderRadius}px;
    }

    entry {
      text-color: inherit;
      border: inherit;
      placeholder: "";
    }

    listview {
    	layout: horizontal;
      border: inherit;
      padding: 0;
    }

    element {
    	padding: 0px ${toString config.theme.spacing.s}px;
    	margin: ${toString config.theme.spacing.xs}px 0px;
    	spacing: ${toString config.theme.spacing.xs}px;
    	border-radius: ${toString config.theme.borderRadius}px;
    }

    element normal.normal {
    	text-color: inherit;
    	background-color: inherit;
    }

    element normal.urgent {
    	text-color: #${config.theme.colors.base08};
    }

    element normal.active {
    	text-color: #${config.theme.colors.base0D};
    }

    element alternate.normal {
    	text-color: inherit;
    	background-color: inherit;
    }

    element alternate.active {
    	text-color: #${config.theme.colors.base0D};
    }

    element selected {
    	text-color: #${config.theme.colors.base00};
    }

    element selected.normal {
    	background-color: #${config.theme.colors.base0D};
    	text-color: #${config.theme.colors.base00};
    }

    element selected.urgent {
    	background-color: #${config.theme.colors.base08};
    }

    element selected.active {
    	background-color: #${config.theme.colors.base03};
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
