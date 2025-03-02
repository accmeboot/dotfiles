{
  description = "Dotfiles for accme's configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";

    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix = {
      url = "github:danth/stylix/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, nixpkgs, home-manager, stylix }: {
    nixosConfigurations = {
      "7950x3d-xtx" = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./hosts/7950x3d-xtx/default.nix
          ./hosts/7950x3d-xtx/packages.nix

          inputs.home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              backupFileExtension = "backup";
              users.accme = {
                imports = [
                  ./modules/home-manager/default.nix
                  ./modules/home-manager/eww/default.nix
                  ./modules/home-manager/mako/default.nix
                  ./modules/home-manager/mangohud/default.nix
                  ./modules/home-manager/rofi/default.nix
                  ./modules/home-manager/sway/default.nix
                  ./modules/home-manager/nvim/default.nix
                  ./modules/home-manager/kitty/default.nix
                  ./modules/home-manager/tmux/default.nix
                  ./modules/home-manager/yazi/default.nix
                  ./modules/home-manager/starship/default.nix
                  ./modules/home-manager/zsh/default.nix
                  ./modules/home-manager/fastfetch/default.nix
                ];
              };
            };
          }


          inputs.stylix.nixosModules.stylix 
          ./modules/home-manager/stylix/default.nix

        ];
      };
    };
  };
}
