{ config, ... }:

let colors = config.lib.stylix.colors;
in {
  programs.swaylock = {
    enable = true;
    settings = {
      image = config.stylix.image;
      color = "${colors.base00}";
      font-size = config.stylix.fonts.sizes.popups;
      indicator-idle-visible = true;
      indicator-radius = 100;

      ring-color = "${colors.base01}";
      ring-ver-color = "${colors.base0D}";
      ring-wrong-color = "${colors.base08}";
      ring-clear-color = "${colors.base0A}";

      key-hl-color = "${colors.base05}";

      line-color = "${colors.base00}";
      line-ver-color = "${colors.base0D}";
      line-wrong-color = "${colors.base08}";
      line-clear-color = "${colors.base0A}";

      inside-color = "${colors.base00}";
      inside-ver-color = "${colors.base00}";
      inside-wrong-color = "${colors.base00}";
      inside-clear-color = "${colors.base00}";

      separator-color = "${colors.base01}";

      text-color = "${colors.base05}";
      text-ver-color = "${colors.base05}";
      text-wrong-color = "${colors.base05}";
      text-clear-color = "${colors.base05}";

      text-caps-lock-color = "${colors.base05}";

      show-failed-attempts = true;
    };
  };
}
