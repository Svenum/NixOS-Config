{ lib, config, ... }:

{
  imports = [
    ./network.nix
    ./packages.nix
    ./nvim.nix
  ];

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;  
}
