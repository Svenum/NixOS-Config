{
  description = "Sven's NixOS Flake";
  nixConfig = {
    experimantal-features = [ "nix-command" "flakes" ];
    substituers = [
      "https://cache.nixos.org/"
    ];
    extra-substituers = [
      "https://nix-community.cachix.org"
    ];
    extra-trusted-public-keys =[
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];
  };
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    
    tuxedo-nixos = {
      url = "github:Svenum/tuxedo-nixos";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    solaar = {
      url = "github:Svenum/Solaar-Flake";
    };
  };

  outputs = inputs@{ self, nixpkgs, home-manager, solaar, tuxedo-nixos, ... }:
  let
    defaultModules = [
      # All
      ./systems/all/default.nix
      
      # Home
      home-manager.nixosModules.home-manager {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        #home-manager.users.susven = {
        #  imports = [
        #    ./homes/susven/default.nix
        #  ];
        #};
        home-manager.users.sven = {
          imports = [
            ./homes/sven/default.nix
          ];
        };
      }
    ];
  in
    {
    nixosConfigurations = {
      srv-nixostest = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = inputs;
        modules = defaultModules ++ [
	        # System
          ./systems/srv-nixostest/default.nix
        ];
      };
      Ni = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = inputs;
        modules = defaultModules ++ [
	        # System
          ./systems/Ni/default.nix

          # Solaar
          ({pkgs, ...}: {
            environment.systemPackages = [solaar.packages.${pkgs.system}.default];
          })
        ];
      };
      San = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = inputs;
        modules = defaultModules ++ [
	        # System
          ./systems/San/default.nix

          # Tuxedo
          tuxedo-nixos.nixosModules.default

          # Solaar
          ({pkgs, ...}: {
            environment.systemPackages = [solaar.packages.${pkgs.system}.default];
          })
        ];
      };
    };
  };
}

