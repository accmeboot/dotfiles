{ config, pkgs, ... }: 
let
  stylix = pkgs.fetchFromGitHub {
    owner = "danth";
    repo = "stylix";
    rev = "release-24.11"; # should match the nixos version
    sha256 = "sha256-O0iFoytYpSxQdWeggIvrHjU5kmX/SRC9mcah9GbwlHk=";
  };
in {
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users.accme = { pkgs, ... }: {
      imports = [ (import stylix).homeManagerModules.stylix ];
      
      stylix = {
        enable = true;
        image = ../../../assets/wallpapers/gruvbox_image40.png;
        # Define colors inline
        base16Scheme = {
          scheme = "Custom Gruvbox";
          author = "accme";
          base00 = "282828"; # background
          base01 = "665c54"; # black (color0)
          base02 = "928374"; # black (color8)
          base03 = "a89984"; # cursor
          base04 = "d4be98"; # foreground
          base05 = "d4be98"; # white (color7)
          base06 = "d4be98"; # white (color15)
          base07 = "d4be98"; # bright white
          base08 = "ea6962"; # red
          base09 = "e78a4e"; # yellow/orange
          base0A = "d8a657"; # bright yellow
          base0B = "a9b665"; # green
          base0C = "89b482"; # cyan
          base0D = "7daea3"; # blue
          base0E = "d3869b"; # magenta
          base0F = "ea6962"; # bright red
        };

        targets = {
          foot.enable = false;
          kitty.enable = false;
          alacritty.enable = false;
          neovim.enable = false;
          tmux.enable = false;
        };

        fonts.sizes = {
          applications = 9;
          desktop = 9;
          popups = 9;
        };
      };

      gtk = {
        enable = true;
        iconTheme = {
          name = "Gruvbox-Plus-Dark";
          package = pkgs.gruvbox-plus-icons;
        };
        cursorTheme = {
          name = "capitaine-cursors";
          package = pkgs.capitaine-cursors;
          size = 16;
        };
        gtk3 = {
          extraConfig.gtk-application-prefer-dark-theme = true;
        };
      };
      
      home.stateVersion = "24.11";
    };
    backupFileExtension = "backup";
  };
}
