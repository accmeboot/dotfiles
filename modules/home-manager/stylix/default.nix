{ pkgs, ... }:
{
  stylix = {
    enable = true;
    polarity = "dark";

    image = "${../../../assets/wallpapers/cyberpunk_catppuccin.jpg}";

    base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";

    targets = {
      starship.enable = false;
      waybar.enable = false;
      mako.enable = false;
    };

    fonts = {
      serif = {
        package = pkgs.inter;
        name = "Inter";
      };
      sansSerif = {
        package = pkgs.inter;
        name = "Inter";
      };
      monospace = {
        package = pkgs.inter;
        name = "Inter";
      };
      sizes = {
        applications = 9;
        desktop = 9;
        popups = 9;
        terminal = 11;
      };
    };
  };
}
