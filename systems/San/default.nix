{ lib, config, ... }:

{
  systemConfig = {
    theme = {
      flavour = "latte";
      accent = "teal";
      mode = "light";
    };
  };

  imports = [
    ./network.nix
    ./packages.nix
    ./virtualisation.nix
    ./nvidia.nix
    ./hardware.nix
    ./kernel.nix
    ./fs.nix
    ./tlp.nix
    ./desktop.nix
    ./devices.nix
  ];

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;  
}
