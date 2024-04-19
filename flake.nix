{
  description = "Sven's NixOS Flake";

  outputs = { self, nixpkgs-unstable, nixpkgs-stable, home-manager, nixos-hardware, solaar, plasma-manager, auto-cpufreq, nixVirt, lanzaboote, ... }@inputs:
  let
    lib = nixpkgs-unstable.lib;
    pkgs-stable = nixpkgs-stable.legacyPackages.x86_64-linux;
  in
  {
    nixosConfigurations = {
      Yon = lib.nixosSystem {
        specialArgs = {
          inherit (inputs) home-manager;
          inherit (inputs) solaar;
          inherit (inputs) plasma-manager;
          inherit (inputs) auto-cpufreq;
          inherit (inputs) nixVirt;
          inherit (inputs) lanzaboote;
          inherit (inputs) nixos-hardware;
          inherit pkgs-stable;
          settings = import ./hosts/Yon/settings.nix;
        };
        system = "x86_64-linux";
        modules = [
          ./hosts/Yon
        ];
      };

      #Ni = lib.nixosSystem {
      #  specialArgs = {
      #    inherit (inputs) home-manager;
      #    inherit (inputs) solaar;
      #    inherit (inputs) plasma-manager;
      #    inherit (inputs) nixVirt;
      #    settings = import ./hosts/Ni/settings.nix;
      #  };
      #  system = "x86_64-linux";
      #  modules = [
      #    ./hosts/Ni
      #  ];
      #};

      #San = lib.nixosSystem {
      #  specialArgs = {
      #    inherit (inputs) home-manager;
      #    inherit (inputs) solaar;
      #    inherit (inputs) plasma-manager;
      #    inherit (inputs) nixVirt;
      #    settings = import ./hosts/San/settings.nix;
      #  };
      #  system = "x86_64-linux";
      #  modules = [
      #    ./hosts/San
      #  ];
      #};

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
          inherit (inputs) solaar;
          inherit (inputs) nixVirt;
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

    overlays = {
      pkgs-set = (
        final: prev: {
          stable = import inputs.nixpkgs-stable { system = final.system; };
        }
      );
    };
  };

  nixConfig = {
    experimantal-features = [ "nix-command" "flakes" ];
    substituers = [
      "https://cache.nixos.org/"
      "https://nix-community.cachix.org"
    ];
    trusted-public-keys =[
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];
  };

  inputs = {
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-23.11";
    
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    plasma-manager = {
      url = "github:pjones/plasma-manager";
      inputs = {
        nixpkgs.follows = "nixpkgs-unstable";
        home-manager.follows = "home-manager";
      };
    };

    solaar = {
      url = "github:Svenum/Solaar-Flake/main";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    auto-cpufreq = {
      url = "github:AdnanHodzic/auto-cpufreq";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    nixVirt = {
      url = "github:AshleyYakeley/NixVirt";
      #url = "github:Svenum/NixVirt/add-boot-options-for-hostdev";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    lanzaboote = {
      url = "github:nix-community/lanzaboote/v0.3.0";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
  };
}

