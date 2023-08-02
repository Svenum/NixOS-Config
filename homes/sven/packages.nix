{ home, pkgs, ... }:

{
  home.packages = with pkgs; [
    caffeine-ng
    haskellPackages.tetris
    #handbrake
  ];
}
