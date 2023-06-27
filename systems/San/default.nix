{ ... }:

{
  imports = [
    ./network.nix
    ./packages.nix
    ./virtualisation.nix
    ./nvidia.nix
    ./hardware.nix
    ./kernel.nix
    ./fs.nix
  ];
}
