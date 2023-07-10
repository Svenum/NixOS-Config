{ lib, ... }:

{
  imports = [
    ./network.nix
    ./kernel.nix
    ./nvim.nix
    ./tmux.nix
    ./skel.nix
    ./fs.nix
  ];
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
}
