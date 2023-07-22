{ home, pkgs, ... }:

{
  home.packages = with pkgs; [
    caffeine-ng
    handbrake
    libdvdcss
  ];
}
