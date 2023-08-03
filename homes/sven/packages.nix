{ home, pkgs, ... }:

let
  tetris = pkgs.callPackage ../../custom-nixpkgs/tetris {};
{
  home.packages = with pkgs; [
    caffeine-ng
    tetris
    #handbrake
  ];
}
