{ lib, config, ... }:

{
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
    ./nvim.nix
    ./tmux.nix
    ./skel.nix
    ./devices.nix
    ./shell.nix
  ];

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;  
}
