{ config, pkgs, ... }: 
let
  stylix = pkgs.fetchFromGitHub {
    owner = "danth";
    repo = "stylix";
    rev = "release-24.11"; # should match the nixos version
    sha256 = "sha256-7SEvP++jm4q9hP8+GXdzrETVi4yNO/3a6Ev1pEsw9cU=";
  };
in {
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users.accme = { pkgs, ... }: {
      imports = [ 
         (import stylix).homeManagerModules.stylix

        ./home-manager/stylix.nix
        ./home-manager/sway.nix
        ./home-manager/eww.nix
        ./home-manager/mako.nix
        ./home-manager/rofi.nix
        ./home-manager/mangohud.nix
      ];
      
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
      };
      
      home.stateVersion = "24.11";
    };
    backupFileExtension = "backup";
  };
}
