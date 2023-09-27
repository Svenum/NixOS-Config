{ lib, config, ... }:

{
  imports = [
    ./network.nix
    ./packages.nix
    ./skel.nix
    ./devices.nix
    ./fs.nix
    ./kernel.nix
    ./nvidia.nix
    ./hardware.nix
    ./virtualisation.nix
  ];

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
