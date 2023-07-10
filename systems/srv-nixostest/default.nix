{ ... }:

{
  imports = [
    ./network.nix
    ./hardware-configuration.nix
    ./nvim.nix
    ./tmux.nix
    ./skel.nix
  ];
}
