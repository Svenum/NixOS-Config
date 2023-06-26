{ config, pkgs, ...}:

{
  home.username = "susven";
  home.homeDirectory = "/home/susven";

  imports = [
    ./flatpak.nix
    ./desktop.nix
  ];

  home.stateVersion = "22.11";

  programs.home-manager.enable = true;
}
