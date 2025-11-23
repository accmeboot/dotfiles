{ config, ... }: {
  services.swayosd.enable = true;

  home.file.".config/swayosd/style.css".text = ''
    window#osd {
      border-radius: ${toString config.theme.borderRadius}px;
      border: none;
      background: #${config.theme.colors.base01};
    }

    #container {
      margin: ${toString config.theme.spacing.m}px;
    }

    image,
    label {
      color: #${config.theme.colors.base05};
    }

    progressbar {
      min-height: 33px;
      border-radius: ${toString config.theme.borderRadius}px;
      background: transparent;
      border: none;
    }

    trough {
      min-height: inherit;
      border-radius: inherit;
      border: none;
      background: alpha(#${config.theme.colors.base0D}, 0.5);
    }

    progress {
      min-height: inherit;
      border-radius: 0px;
      border: none;
      background: #${config.theme.colors.base0D};
    }
  '';
}
