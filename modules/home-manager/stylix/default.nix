{ pkgs, inputs, ... }:
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
        package = inputs.apple-fonts.packages.${pkgs.system}.sf-pro-nerd;
        name = "SFProDisplay Nerd Font";
      };
      sansSerif = {
        package = inputs.apple-fonts.packages.${pkgs.system}.sf-pro-nerd;
        name = "SFProDisplay Nerd Font";
      };
      monospace = {
        package = inputs.apple-fonts.packages.${pkgs.system}.sf-pro-nerd;
        name = "SFProDisplay Nerd Font";
      };
      sizes = {
        applications = 11;
        desktop = 11;
        popups = 11;
        terminal = 11;
      };
    };

   cursor = {
     package = pkgs.capitaine-cursors;
     name = "capitaine-cursors";
     size = 16;
   };

   icons = {
    enable = true;
    package = pkgs.reversal-icon-theme;
    dark = "Reversal";
    light = "Reversal";
   };
  };
}
