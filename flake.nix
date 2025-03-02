{
  description = "Dotfiles for accme's configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix = {
      url = "github:danth/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, nixpkgs, home-manager, stylix }: {
    nixosConfigurations = {
      "7950x3d-xtx" = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./hosts/7950x3d-xtx/default.nix

            inputs.home-manager.nixosModules.home-manager
            inputs.stylix.nixosModules.stylix 

            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                users.accme = {
                  imports = [
                    ./modules/home-manager/default.nix
                    ./modules/home-manager/stylix/default.nix
                    ./modules/home-manager/eww/default.nix
                    ./modules/home-manager/mako/default.nix
                    ./modules/home-manager/mangohud/default.nix
                    ./modules/home-manager/rofi/default.nix
                    ./modules/home-manager/sway/default.nix
                  ];
                };
              };
            }
        ];
      };
    };
  };
}
