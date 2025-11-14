{ config, pkgs, ... }: {
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
    	text-color: #${config.theme.colors.base05};
      border: 0px;

      font: "serif";
    }

    window {
    	location: center;
    	width: 350px;
    	background-color: #${config.theme.colors.base01};
      border-radius: ${toString config.theme.borderRadius};
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
    	background-color: #${config.theme.colors.base00};
    	text-color: #${config.theme.colors.base05};
    }

    entry {
      text-color: inherit;
      border: inherit;
      placeholder: "";
    	background-color: #${config.theme.colors.base00};
    	padding: ${toString config.theme.spacing.s}px ${
       toString config.theme.spacing.xs
     }px;
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
    	padding: ${toString config.theme.spacing.s}px ${
       toString (config.theme.spacing.xs + config.theme.borderWidth)
     }px;
    	margin: 0px;
    	spacing: ${toString config.theme.spacing.xs}px;
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
