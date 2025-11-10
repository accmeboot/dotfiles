{ config, ... }: {
  services.mako = {
    enable = true;
    settings = {
      sort = "-time";
      layer = "overlay";
      border-size = 1;
      border-radius = config.theme.borderRadius;
      icons = true;

      width = 400;

      default-timeout = 0;
      ignore-timeout = true;
      border-color = "#${config.theme.colors.base03}";
      text-color = "#${config.theme.colors.base05}";
      background-color = "#${config.theme.colors.base00}";
      progress-color = "#${config.theme.colors.base03}";
      font = "Inter 9.5";
      padding = 10;

      icon-border-radius = config.theme.borderRadius;
      max-icon-size = 128; # the default with and height of the icon is 64

      anchor = "top-right";

      outer-margin = toString config.theme.spacing.xxl;
      margin = toString config.theme.spacing.s;
    };
  };
}
