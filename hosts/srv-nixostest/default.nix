{ lib, ... }:

{
  imports = [
    ./network.nix
    ./kernel.nix
    ./fs.nix
    ./desktop.nix
    ../../modules/flatpak
    ../../modules/rdp
  ];
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
}
