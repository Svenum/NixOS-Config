{ home, pkgs, systemConfig, lib, ... }:

let
  tetris = pkgs.callPackage ../../custom-nixpkgs/tetris {};
in
{
  imports = [
    ./plasma.nix
    ./kvm.nix
  ];

  # Add extgra packages
  home.packages = with pkgs; [
    caffeine-ng
    #tetris
    ccrypt
  ];

}
