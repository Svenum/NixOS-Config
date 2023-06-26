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

    home-manager = {
      url = "github:nix-community/home-manager/release-23.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, nixpkgs, home-manager, ... }:
    # Specific system configurations
    let 
    	defaultModules = [
          # All
          ./systems/all/default.nix
	  
	  # Home
          home-manager.nixosModules.home-manager {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.susven = {
              imports = [
                ./homes/susven/default.nix
                ./modules/flatpak.nix
              ];
            };
            home-manager.users.sven = {
              imports = [
                ./homes/sven/default.nix
                ./modules/flatpak.nix
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
        ];
      };
      San = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = inputs;
        modules = defaultModules ++ [
	  # System
          ./systems/San/default.nix
        ];
      };
    };
  };
}

