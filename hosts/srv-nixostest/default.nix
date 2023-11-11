{ lib, ... }:

{
  imports = [
    ./network.nix
    ./kernel.nix
    ./fs.nix
    ./desktop.nix
  ];
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
}
