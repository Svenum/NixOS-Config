{
  description = "Sven's NixOS Flake";

  outputs = { self, nixpkgs, home-manager, solaar, tuxedo-nixos, ... }@inputs:
  let
    lib = nixpkgs.lib;
  in
  {
    nixosConfigurations = {
      srv-nixostest = lib.nixosSystem {
        specialArgs = {
          themeAccent = "teal";
          themeFlavour = "mocha";
          themeMode = "dark";
          userAttrs = {
            sven = {
              isGuiUser = true;
              git = {
                userName = "Svenum";
                userEmail = "s.ziegler@holypenguin.net";
              };
            };
            susven = {
              isGuiUser = true;
              isSudoUser = true;
            };
          };
          inherit (inputs) home-manager;
        };
        system = "x86_64-linux";
        modules = [
          ./hosts/srv-nixostest
          ./hosts/default
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
    nixpkgs = {
      url = "github:NixOS/nixpkgs/nixos-unstable";
    };
    
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
}

