{ ... }:

{
  imports = [
    ./network.nix
    ./packages.nix
    ./hardware-configuration.nix
    ./virtualisation.nix
    ./nvidia.nix
    ./bluetooth.nix
  ];
}
