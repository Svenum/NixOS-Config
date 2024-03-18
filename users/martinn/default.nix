{ home, pkgs, ... }:

let
  tetris = pkgs.callPackage ../../custom-nixpkgs/tetris {};
in
{
  # Add extgra packages
  home.packages = with pkgs; [
    caffeine-ng
    #tetris
    k3b
    skanpage
  ];
}
