{
  description = "Sven's NixOS Flake";

  outputs = { self, nixpkgs, home-manager, solaar, tuxedo-nixos, ... }@inputs:
  let
    lib = nixpkgs.lib;
    tz = "Europe/Berlin";
    kbLayout = "de";
    de = {
      name = "plasma";
      defaultWayland = true;
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
    printerAttrs =[
      {
        name = "Epson_ET-2720-Series";
        deviceUri = "https://pr-epson.intra.holypenguin.net:631/ipp/print";
        model = "epson-inkjet-printer-escpr/Epson-ET-2720_Series-epson-escpr-en.ppd";
        description = "Epson ET-2720";
        isDefault = true;
      }
    ]; 
    locale = "en_DE";
    shell = "zsh";
  in
  {
    nixosConfigurations = {
      srv-nixostest = lib.nixosSystem {
        specialArgs = {
          inherit (inputs) home-manager;
          inherit tz;
          inherit kbLayout;
          de = {
            name = "plasma";
          };
          inherit userAttrs;
          inherit printerAttrs;
          inherit locale;
          inherit shell;
          networkConfig = {
            hostName = "srv-nixostest";
            interface = "enp1s0";
            address = "172.16.0.111";
            prefixLength = 24;
            defaultGateway = "172.16.0.1";
            nameservers = [ "172.16.0.3" "172.16.0.4" ];
          };
          themeAccent = "teal";
          themeFlavour = "mocha";
          themeMode = "dark";
        };
        system = "x86_64-linux";
        modules = [
          ./hosts/srv-nixostest.nix
        ];
      };
      San = lib.nixosSystem {
        specialArgs = {
          inherit (inputs) home-manager;
          inherit (inputs) tuxedo-nixos;
          inherit (inputs) solaar;
          inherit tz;
          inherit kbLayout;
          inherit de;
          inherit userAttrs;
          inherit printerAttrs;
          inherit locale;
          inherit shell;
          nvidia = {
            hybridGraphics = true;
            nvidiaBusId = "PCI:1:0:0";
            amdgpuBusId = "PCI:5:0:0";
          };
          tlpAttrs = {
            deviceBlacklist = "03:00.0";
          };
          networkConfig = {
            hostName = "San";
            useDHCP = true;
          };
          themeAccent = "teal";
          themeFlavour = "latte";
          themeMode = "light";
        };
        system = "x86_64-linux";
        modules = [
          ./hosts/San.nix
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
      inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.05";
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

