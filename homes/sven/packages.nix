{ home, pkgs, ... }:

{
  home.packages = with pkgs; [
    caffeine-ng
    latte-dock
  ];
}
