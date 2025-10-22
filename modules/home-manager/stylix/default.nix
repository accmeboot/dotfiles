{ config, pkgs, ... }: {
  stylix = {
    enable = true;
    polarity = "dark";

    image = "${../../../assets/wallpapers/evangelion.png}";

    # base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-dark-hard.yaml";

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
        applications = 9.5;
        desktop = 11;
        popups = 11;
        terminal = 11;
      };
    };
  };
}
