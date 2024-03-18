{
  description = "Sven's NixOS Flake";

  outputs = { self, nixpkgs, home-manager, solaar, plasma-manager, ... }@inputs:
  let
    lib = nixpkgs.lib;
  in
  {
    nixosConfigurations = {
      Ni = lib.nixosSystem {
        specialArgs = {
          inherit (inputs) home-manager;
          inherit (inputs) solaar;
          inherit (inputs) plasma-manager;
          settings = import ./hosts/Ni/settings.nix;
        };
        system = "x86_64-linux";
        modules = [
          ./hosts/Ni
        ];
      };

      San = lib.nixosSystem {
        specialArgs = {
          inherit (inputs) home-manager;
          inherit (inputs) solaar;
          inherit (inputs) plasma-manager;
          inherit (inputs) envycontrol;
          settings = import ./hosts/San/settings.nix;
        };
        system = "x86_64-linux";
        modules = [
          ./hosts/San
        ];
      };

      srv-nixostest = lib.nixosSystem {
        specialArgs = {
          inherit (inputs) home-manager;
          inherit (inputs) plasma-manager;
          settings = import ./hosts/srv-nixostest/settings.nix;
        };
        system = "x86_64-linux";
        modules = [
          ./hosts/srv-nixostest
        ];
      };
      
      Zeta = lib.nixosSystem {
        specialArgs = {
          inherit (inputs) home-manager;
          inherit (inputs) plasma-manager;
          settings = import ./hosts/Zeta/settings.nix;
        };
        system = "x86_64-linux";
        modules = [
          ./hosts/Zeta
        ];
      };
      
      PC-Carmen = lib.nixosSystem {
        specialArgs = {
          inherit (inputs) home-manager;
          inherit (inputs) plasma-manager;
          inherit (inputs) solaar;
          settings = import ./hosts/PC-Carmen/settings.nix;
        };
        system = "x86_64-linux";
        modules = [
          ./hosts/PC-Carmen
        ];
      };
    };
  };

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
    
    #tuxedo-nixos = {
    #  url = "github:Svenum/tuxedo-nixos";
    #  inputs.nixpkgs.follows = "nixpkgs-stable";
    #};

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    plasma-manager = {
      url = "github:pjones/plasma-manager";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        home-manager.follows = "home-manager";
      };
    };

    solaar = {
      url = "github:Svenum/Solaar-Flake/latest";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    envycontrol = {
      url = github:bayasdev/envycontrol;
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
}

