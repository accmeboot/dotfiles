{ config, ... }:
let
  theme = config.stylix.theme;
  colors = config.lib.stylix.colors;
in {
  services.swayosd.enable = true;

  home.file.".config/swayosd/style.css".text = ''
    window#osd {
      border-radius: ${toString theme.borderRadius}px;
      border: none;
      background: #${colors.base01};
    }

    #container {
      margin: ${toString theme.spacing.m}px;
    }

    image,
    label {
      color: #${colors.base05};
    }

    progressbar {
      min-height: 28px;
      border-radius: ${toString theme.borderRadius}px;
      background: transparent;
      border: none;
    }

    trough {
      min-height: inherit;
      border-radius: inherit;
      border: none;
      background: alpha(#${colors.base05}, 0.5);
    }

    progress {
      min-height: inherit;
      border-radius: 0px;
      border: none;
      background: #${colors.base05};
    }
  '';
}
