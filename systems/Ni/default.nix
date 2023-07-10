{ lib, config, ... }:

{
  imports = [
    ./network.nix
    ./packages.nix
    ./nvim.nix
    ./tmux.nix
    ./skel.nix
  ];

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;  
}
