{ home, pkgs, ... }:

let
  tetris = pkgs.callPackage ../../custom-nixpkgs/tetris {};
in
{
  home.packages = with pkgs; [
    caffeine-ng
    tetris
  ];
}
