{ lib, ... }:

{
  imports = [
    ./network.nix
    ./kernel.nix
    ./skel.nix
    ./fs.nix
  ];
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
}
