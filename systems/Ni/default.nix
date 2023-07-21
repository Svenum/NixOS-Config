{ lib, config, ... }:

{
  imports = [
    ./network.nix
    ./packages.nix
    ./nvim.nix
    ./tmux.nix
    ./skel.nix
    ./devices.nix
    ./shell.nix
    ./fs.nix
    ./kernel.nix
    ./nvidia.nix
  ];

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
