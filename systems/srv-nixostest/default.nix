{ lib, ... }:

{
  imports = [
    ./network.nix
    ./kernel.nix
    ./nvim.nix
    ./skel.nix
    ./fs.nix
    ./shell.nix
  ];
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
}
