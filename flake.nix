{
  description = "Dotfiles for accme's configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix = {
      url = "github:nix-community/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, nixpkgs, home-manager, stylix, darwin }:{
    nixosConfigurations = {
      "7950x3d-xtx" = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./hosts/7950x3d-xtx/default.nix
          ./hosts/7950x3d-xtx/packages.nix

          inputs.home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = false;
              useUserPackages = true;
              backupFileExtension = "backup";
              users.accme = {
                imports = [
                  ./hosts/7950x3d-xtx/home.nix
                  ./modules/home-manager/gtk/default.nix
                  ./modules/home-manager/eww/default.nix
                  ./modules/home-manager/mako/default.nix
                  ./modules/home-manager/mangohud/default.nix
                  ./modules/home-manager/rofi/default.nix
                  ./modules/home-manager/sway/default.nix
                  ./modules/home-manager/nvim/default.nix
                  # ./modules/home-manager/nvim/base16.nix
                  ./modules/home-manager/kitty/default.nix
                  ./modules/home-manager/tmux/default.nix
                  ./modules/home-manager/yazi/default.nix
                  ./modules/home-manager/starship/default.nix
                  ./modules/home-manager/zsh/default.nix
                  ./modules/home-manager/fastfetch/default.nix


                  inputs.stylix.homeModules.stylix
                  ./modules/home-manager/stylix/default.nix
                ];
              };
            };
          }
        ];
      };
    };

    darwinConfigurations = {
      "mbp-m1" = darwin.lib.darwinSystem {
        system = "aarch64-darwin";
        modules = [
          ./hosts/mbp-m1/default.nix
          
          home-manager.darwinModules.home-manager
          {
            home-manager = {
              backupFileExtension = "backup";
              users.Mikhail_Vialov = {
                imports = [
                  ./hosts/mbp-m1/home.nix
                  ./modules/home-manager/aerospace/default.nix
                  ./modules/home-manager/nvim/default.nix
                  # ./modules/home-manager/nvim/base16.nix
                  ./modules/home-manager/kitty/default.nix
                  ./modules/home-manager/tmux/default.nix
                  ./modules/home-manager/yazi/default.nix
                  ./modules/home-manager/starship/default.nix
                  ./modules/home-manager/zsh/default.nix
                  ./modules/home-manager/fastfetch/default.nix

                  stylix.homeModules.stylix
                  ./modules/home-manager/stylix/default.nix
                ];
              };
            };
          }
        ];
      };
    };
  };
}
