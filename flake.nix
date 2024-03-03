{
  description = "Sven's NixOS Flake";

  outputs = { self, nixpkgs, home-manager, solaar, ... }@inputs:
  let
    lib = nixpkgs.lib;
    tz = "Europe/Berlin";
    kbLayout = "de";
    de = {
      name = "plasma";
      waylandDefault = true;
    };
    userAttrs = {
      "sven" = {
        isGuiUser = true;
        isSudoUser = true;
        git = {
          userName = "Svenum";
          userEmail = "s.ziegler@holypenguin.net";
        };
      };
    };
    enableScanner = true;
    printerAttrs =[
      {
        name = "Epson_ET-2720-Series";
        deviceUri = "https://pr-epson.intra.holypenguin.net:631/ipp/print";
        model = "epson-inkjet-printer-escpr/Epson-ET-2720_Series-epson-escpr-en.ppd";
        description = "Epson ET-2720";
        isDefault = true;
      }
      {
        name = "HP_Officejet_5740-Series";
        deviceUri = "https://pr-hp.intra.holypenguin.net/ipp/printers";
        model = "HP/hp-officejet_5740_series.ppd.gz";
        description = "HP Officejet 5740";
        isDefault = false;
      }
    ]; 
    locale = "en_DE";
    shell = "zsh";
  in
  {
    nixosConfigurations = {
      Ni = lib.nixosSystem {
        specialArgs = {
          inherit (inputs) home-manager;
          inherit (inputs) solaar;
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

    solaar = {
      url = "github:Svenum/Solaar-Flake/latest";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
}

