{ config, ... }:
{
  programs.ghostty = {
    enable = true;
    settings = {
      font-family = "";
      background-opacity = config.theme.opacity;
      cursor-style = "block";
      shell-integration-features = "no-cursor";

      window-padding-x = config.theme.spacing.m;
      window-padding-y = config.theme.spacing.m;
      window-padding-balance = true;
    };
  };
}
