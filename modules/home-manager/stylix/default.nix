{ config, pkgs, ... }: {
  #----------------------------------------------------------------------------#
  # STYLIX THEME CONFIGURATION                                                  #
  #----------------------------------------------------------------------------#
  stylix = {
    enable = true;
    image = ../../assets/wallpapers/bay.JPG;  # wallpaper path
    polarity = "dark";  # dark theme preference

    # Custom color scheme definition
    base16Scheme = {
      scheme = "Dawn";
      author = "accme";
      # Base colors for UI elements
      base00 = "1A1A1A";  # background
      base01 = "2A2A2A";  # lighter background
      base02 = "3A3A3A";  # selection background
      base03 = "756E6B";  # comments, invisibles
      base04 = "988F8C";  # dark foreground
      base05 = "CBC6C1";  # default foreground
      base06 = "DCD7D2";  # light foreground
      base07 = "EAE5E0";  # light background
      # Accent colors
      base08 = "C5907B";  # variables
      base09 = "C4B187";  # numbers
      base0A = "D7C897";  # warnings
      base0B = "B8C196";  # strings
      base0C = "A699B7";  # regex, escaped chars
      base0D = "9F8B96";  # functions
      base0E = "B8B0A4";  # keywords
      base0F = "7B9F7B";  # deprecations
    };

    #--------------------------------------------------------------------------#
    # APPLICATION TARGETS                                                       #
    #--------------------------------------------------------------------------#
    targets = {
      kitty.enable = false;    # terminal emulator
      neovim.enable = false;   # text editor
      tmux.enable = false;     # terminal multiplexer
      rofi.enable = false;     # application launcher
    };

    #--------------------------------------------------------------------------#
    # FONT CONFIGURATION                                                        #
    #--------------------------------------------------------------------------#
    fonts.sizes = {
      applications = 9;  # general UI font size
      desktop = 9;      # desktop environment font size
      popups = 9;       # notification/dialog font size
    };
  };
}
