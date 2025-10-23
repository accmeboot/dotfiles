{ pkgs, ... }:
{
  stylix = {
    enable = true;
    polarity = "dark";

    image = "${../../../assets/wallpapers/evangelion.png}";

    # base16Scheme = import ../theme/monochrome-base16.nix;
    # base16Scheme = "${pkgs.base16-schemes}/share/themes/grayscale-dark.yaml";

    targets = {
      starship.enable = false;
      waybar.enable = false;
      mako.enable = false;

      # zen-browser.profileNames = [ "default" ]; currently the theme looks really bad
      zen-browser.enable = false;
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
        applications = 9.5;
        desktop = 11;
        popups = 11;
        terminal = 11;
      };
    };
  };
}
