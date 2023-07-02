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
      url = "github:blitz/tuxedo-nixos";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager/release-23.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, nixpkgs, home-manager, tuxedo-nixos, ... }:
    # Specific system configurations
    let 
      homeDefaultConfig = {
        # Zsh
        ".zshrc".source = ./config_files/zshrc;
        ".p10k.zsh".source = ./config_files/p10k.zsh;
        
        # Flatpak overrides
        ".local/share/flatpak/overrides".source = ./config_files/local/share/flatpak/overrides;
          
        # KDE
        ".config/kglobalshortcutsrc".source = ./config_files/config/kglobalshortcutsrc;
        ".config/kcminputrc".source = ./config_files/config/kcminputrc;
        ".config/kwinrc".source = ./config_files/config/kwinrc;
        ".config/kdeglobals".source = ./config_files/config/kdeglobals;
        ".config/kscreenlockerrc".source = ./config_files/config/kscreenlockerrc;
        ".config/ksplashrc".source = ./config_files/config/ksplashrc;
        ".config/plasma-localerc".source = ./config_files/config/plasma-localerc;
        ".config/plasmashellrc".source = ./config_files/config/plasmashellrc;
        ".config/plasma-org.kde.plasma.desktop-appletsrc".source = ./config_files/config/plasma-org.kde.plasma.desktop-appletsrc;
        ".config/kdedefaults".source = ./config_files/config/kdedefaults;
        ".config/auroraerc".source = ./config_files/config/auroraerc;
        ".config/systemsettingsrc".source = ./config_files/config/systemsettingsrc;
        ".local/share/plasma/plasmoids".source = ./config_files/local/share/plasma/plasmoids;
      };
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
              home.file = homeDefaultConfig;
            };
            home-manager.users.sven = {
              imports = [
                ./homes/sven/default.nix
                ./modules/flatpak.nix
              ];
              home.file = homeDefaultConfig;
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
          # Tuxedo
          tuxedo-nixos.nixosModules.default
        ];
      };
    };
  };
}

