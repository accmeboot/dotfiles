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

    solaar = {
      url = "github:Svenum/Solaar-Flake/main";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    apple-fonts = {
      url = "github:Lyndeno/apple-fonts.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, nixpkgs, home-manager, stylix, darwin, solaar
    , zen-browser, apple-fonts }: {
      nixosConfigurations = {
        "7950x3d-xtx" = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = { inherit inputs; };
          modules = [
            solaar.nixosModules.default
            home-manager.nixosModules.home-manager

            ./hosts/7950x3d-xtx/default.nix

            {
              home-manager = {
                useGlobalPkgs = false;
                useUserPackages = true;
                backupFileExtension = "backup";
                extraSpecialArgs = { inherit inputs; };
                users.accme = {
                  imports = [
                    ./hosts/7950x3d-xtx/home.nix
                    ./modules/home-manager/profiles/base.nix
                    ./modules/home-manager/profiles/linux-desktop.nix
                  ];
                };
              };
            }
          ];
        };

        "rog16" = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = { inherit inputs; };
          modules = [
            home-manager.nixosModules.home-manager

            ./hosts/rog16/default.nix

            {
              home-manager = {
                useGlobalPkgs = false;
                useUserPackages = true;
                backupFileExtension = "backup";
                extraSpecialArgs = { inherit inputs; };
                users.accme = {
                  imports = [
                    ./hosts/rog16/home.nix
                    ./modules/home-manager/profiles/base.nix
                    ./modules/home-manager/profiles/linux-desktop.nix
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
                extraSpecialArgs = { inherit inputs; };
                users.Mikhail_Vialov = {
                  imports = [
                    ./hosts/mbp-m1/home.nix
                    ./modules/home-manager/profiles/base.nix
                    ./modules/home-manager/profiles/darwin.nix
                  ];
                };
              };
            }
          ];
        };
      };
    };
}
