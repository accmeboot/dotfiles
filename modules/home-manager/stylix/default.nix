{ pkgs, inputs, ... }: {

  imports = [ inputs.stylix.homeModules.stylix ];

  stylix = {
    enable = true;
    autoEnable = false;

    polarity = "light";

    base16Scheme = import ../colorschemes/cyberdream-light.nix;

    targets = {
      gtk.enable = true;
      qt.enable = true;
      yazi.enable = true;
    };

    fonts = {
      serif = { name = "Arimo Nerd Font"; };
      sansSerif = { name = "Arimo Nerd Font"; };
      monospace = { name = "JetBrainsMono Nerd Font"; };
      sizes = {
        applications = 10;
        desktop = 10;
        popups = 12;
        terminal = 12;
      };
    };

    cursor = {
      package = pkgs.vanilla-dmz;
      name = "Vanilla-DMZ";
      size = 16;
    };

    icons = {
      enable = true;
      package = pkgs.papirus-icon-theme;
      dark = "Papirus";
      light = "Papirus";
    };
  };
}
