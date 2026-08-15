{ lib, config, ... }:
let
  lightColors = config._colorSchemes.light;
  darkColors = config._colorSchemes.dark;

  autoTheme = config.ghostty.autoTheme or false;
  isDarkMode = config.stylix.polarity == "dark";
  defaultTheme = if isDarkMode then "stylix-dark" else "stylix-light";

  themeConfig = if autoTheme then
    "theme=dark:stylix-dark,light:stylix-light"
  else
    "theme=${defaultTheme}";
in {
  options.ghostty = {
    autoTheme = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description =
        "Enable automatic theme switching based on system preference";
    };
  };

  config = {
    home.file.".config/ghostty/config".text = ''
      font-family=""
      background-blur=90
      cursor-style=block
      shell-integration-features=no-cursor
      app-notifications=false
      window-padding-x=8
      window-padding-y=8
      window-padding-balance=true

      ${themeConfig}
    '';

    home.file.".config/ghostty/themes/stylix-light".text = ''
      background=${lightColors.base00}
      foreground=${lightColors.base05}
      cursor-color=${lightColors.base05}
      selection-background=${lightColors.base02}
      selection-foreground=${lightColors.base05}

      palette=0=${lightColors.base00}
      palette=1=${lightColors.base08}
      palette=2=${lightColors.base0B}
      palette=3=${lightColors.base0A}
      palette=4=${lightColors.base0D}
      palette=5=${lightColors.base0E}
      palette=6=${lightColors.base0C}
      palette=7=${lightColors.base05}
      palette=8=${lightColors.base03}
      palette=9=${lightColors.base08}
      palette=10=${lightColors.base0B}
      palette=11=${lightColors.base0A}
      palette=12=${lightColors.base0D}
      palette=13=${lightColors.base0E}
      palette=14=${lightColors.base0C}
      palette=15=${lightColors.base07}
    '';

    home.file.".config/ghostty/themes/stylix-dark".text = ''
      background=${darkColors.base00}
      foreground=${darkColors.base05}
      cursor-color=${darkColors.base05}
      selection-background=${darkColors.base02}
      selection-foreground=${darkColors.base05}

      palette=0=${darkColors.base00}
      palette=1=${darkColors.base08}
      palette=2=${darkColors.base0B}
      palette=3=${darkColors.base0A}
      palette=4=${darkColors.base0D}
      palette=5=${darkColors.base0E}
      palette=6=${darkColors.base0C}
      palette=7=${darkColors.base05}
      palette=8=${darkColors.base03}
      palette=9=${darkColors.base08}
      palette=10=${darkColors.base0B}
      palette=11=${darkColors.base0A}
      palette=12=${darkColors.base0D}
      palette=13=${darkColors.base0E}
      palette=14=${darkColors.base0C}
      palette=15=${darkColors.base07}
    '';
  };
}
