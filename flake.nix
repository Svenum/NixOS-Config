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
      #San = lib.nixosSystem {
      #  specialArgs = {
      #    inherit (inputs) home-manager;
      #    inherit (inputs) solaar;
      #    inherit tz;
      #    inherit kbLayout;
      #    inherit de;
      #    inherit userAttrs;
      #    inherit printerAttrs;
      #    inherit enableScanner;
      #    inherit locale;
      #    inherit shell;
      #    nvidia = {
      #      hybridGraphics = true;
      #      nvidiaBusId = "PCI:1:0:0";
      #      amdgpuBusId = "PCI:5:0:0";
      #    };
      #    tlpAttrs = {
      #      deviceBlacklist = "03:00.0";
      #    };
      #    networkConfig = {
      #      hostName = "San";
      #      useDHCP = true;
      #    };
      #    themeAccent = "teal";
      #    themeFlavour = "latte";
      #    themeMode = "light";
      #  };
      #  system = "x86_64-linux";
      #  modules = [
      #    ./hosts/San.nix
      #  ];
      #};
      #srv-nixostest = lib.nixosSystem {
      #  specialArgs = {
      #    inherit (inputs) home-manager;
      #    inherit tz;
      #    inherit kbLayout;
      #    de = {
      #      name = "plasma";
      #    };
      #    inherit userAttrs;
      #    inherit printerAttrs;
      #    inherit enableScanner;
      #    inherit locale;
      #    inherit shell;
      #    networkConfig = {
      #      hostName = "srv-nixostest";
      #      interface = "enp1s0";
      #      address = "172.16.0.111";
      #      prefixLength = 24;
      #      defaultGateway = "172.16.0.1";
      #      nameservers = [ "172.16.0.3" "172.16.0.4" ];
      #    };
      #    themeAccent = "teal";
      #    themeFlavour = "mocha";
      #    themeMode = "dark";
      #  };
      #  system = "x86_64-linux";
      #  modules = [
      #    ./hosts/srv-nixostest.nix
      #  ];
      #};
      #Zeta = lib.nixosSystem {
      #  specialArgs = {
      #    inherit (inputs) home-manager;
      #    inherit tz;
      #    inherit kbLayout;
      #    nvidia ={
      #      hybridGraphics = false;
      #    };
      #    userAttrs = {
      #      "martinn" = {
      #        isGuiUser = true;
      #        isSudoUser = false;
      #        uid = 1001;
      #      };
      #      "sumartinn" = {
      #        isGuiUser = true;
      #        isSudoUser = true;
      #        uid = 1000;
      #        authorizedKeys = [
      #          "ecdsa-sha2-nistp521 AAAAE2VjZHNhLXNoYTItbmlzdHA1MjEAAAAIbmlzdHA1MjEAAACFBABz8jUkUacu8PahA+mlDCCp3780yrcpAcNZIJ1CFswAbgbWoK+FZxdQ3P43X4cBjKVtz8tthf4xHhkGe6eNC1+ofgHq5bXfIP15ba7AEncdUvreQzPx2Aao7yZFw94piTiZqlQA193SZTw8ggbYPwn3hnXkFT/6ttIEr+18xUMGFM9c1A== sven@Ni"
      #        ];
      #      };
      #    };
      #    inherit printerAttrs;
      #    inherit enableScanner;
      #    locale = "de_DE";
      #    inherit shell;
      #    inherit de;
      #    networkConfig = {
      #      hostName = "Zeta";
      #      useDHCP = true;
      #    };
      #    themeAccent = "peach";
      #    themeFlavour = "mocha";
      #    themeMode = "dark";
      #  };
      #  system = "x86_64-linux";
      #  modules = [
      #    ./hosts/Zeta.nix
      #  ];
      #};
      #PC-Carmen = lib.nixosSystem {
      #  specialArgs = {
      #    inherit (inputs) home-manager;
      #    inherit (inputs) solaar;
      #    inherit tz;
      #    inherit kbLayout;
      #    userAttrs = {
      #      "carmen" = {
      #        isGuiUser = true;
      #        isSudoUser = false;
      #      };
      #      "sudouser" = {
      #        isGuiUser = true;
      #        isSudoUser = true;
      #        authorizedKeys = [
      #          "ecdsa-sha2-nistp521 AAAAE2VjZHNhLXNoYTItbmlzdHA1MjEAAAAIbmlzdHA1MjEAAACFBABz8jUkUacu8PahA+mlDCCp3780yrcpAcNZIJ1CFswAbgbWoK+FZxdQ3P43X4cBjKVtz8tthf4xHhkGe6eNC1+ofgHq5bXfIP15ba7AEncdUvreQzPx2Aao7yZFw94piTiZqlQA193SZTw8ggbYPwn3hnXkFT/6ttIEr+18xUMGFM9c1A== sven@Ni"
      #        ];
      #      };
      #    };
      #    inherit printerAttrs;
      #    inherit enableScanner;
      #    locale = "de_DE";
      #    inherit shell;
      #    inherit de;
      #    networkConfig = {
      #      hostName = "PC-Carmen";
      #      useDHCP = true;
      #    };
      #    themeAccent = "red";
      #    themeFlavour = "latte";
      #    themeMode = "light";
      #  };
      #  system = "x86_64-linux";
      #  modules = [
      #    ./hosts/PC-Carmen.nix
      #  ];
      #};
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
      url = "github:Svenum/Solaar-Flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
}

