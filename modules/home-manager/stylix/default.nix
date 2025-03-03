{ config, pkgs, ... }: {
  #----------------------------------------------------------------------------#
  # STYLIX THEME CONFIGURATION                                                  #
  #----------------------------------------------------------------------------#
  stylix = {
    enable = true;
    image = ../../../assets/wallpapers/bay.JPG;  # wallpaper path
    polarity = "dark";  # dark theme preference

    # base16Scheme = "${pkgs.base16-schemes}/share/themes/rose-pine.yaml";
    # Custom color scheme definition
    base16Scheme = {
      scheme = "Dawn";
      author = "accme";
      base00 = "1A1A1A";
      base01 = "2A2A2A";
      base02 = "3A3A3A";
      base03 = "756E6B";
      base04 = "988F8C";
      base05 = "CBC6C1";
      base06 = "DCD7D2";
      base07 = "EAE5E0";
      base08 = "C5907B";
      base09 = "C4B187";
      base0A = "D7C897";
      base0B = "B8C196";
      base0C = "A699B7";
      base0D = "9F8B96";
      base0E = "B8B0A4";
      base0F = "7B9F7B";
    };

    #--------------------------------------------------------------------------#
    # APPLICATION TARGETS                                                       #
    #--------------------------------------------------------------------------#
    targets = {
      kitty.enable = false;
    };

    #--------------------------------------------------------------------------#
    # FONT CONFIGURATION                                                        #
    #--------------------------------------------------------------------------#
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
        package = pkgs.nerdfonts;
        name = "SFMono Nerd Font";  # macOS's native monospace font
      };
      sizes = {
        applications = 9.5;
        desktop = 9.5;
        popups = 9.5;
      };
    };
  };
}
