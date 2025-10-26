{ ... }:
{
  stylix = {
    enable = true;
    polarity = "dark";

    image = "${../../../assets/wallpapers/cyberpunk_1.jpg}";

    base16Scheme = import ../theme/base16-colors.nix;

    targets = {
      starship.enable = false;
      waybar.enable = false;
      mako.enable = false;

      # zen-browser.profileNames = [ "default" ]; currently the theme looks really bad
      zen-browser.enable = false;
    };

    fonts = {
        serif = {
          name = "JetBrainsMono Nerd Font";
        };
        sansSerif = {
          name = "JetBrainsMono Nerd Font";
        };
        monospace = {
          name = "JetBrainsMono Nerd Font";
        };
      sizes = {
        applications = 10;
        desktop = 10;
        popups = 10;
        terminal = 11;
      };
    };
  };
}
