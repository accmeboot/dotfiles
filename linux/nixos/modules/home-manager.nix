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
         # base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-dark-hard.yaml";
         # Define colors inline
         base16Scheme = {
           scheme = "Custom Gruvbox";
           author = "accme";
           base00 = "282828";
           base01 = "3a3735";
           base02 = "3a3735";
           base03 = "3a3735";
           base04 = "d4be98";
           base05 = "d4be98";
           base06 = "d4be98";
           base07 = "d4be98";
           base08 = "ea6962";
           base09 = "e78a4e";
           base0A = "d8a657";
           base0B = "a9b665";
           base0C = "89b482";
           base0D = "7daea3";
           base0E = "d3869b";
           base0F = "ea6962";
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
