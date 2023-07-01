{ config, pkgs, ...}:

{
  home.username = "susven";
  home.homeDirectory = "/home/susven";

  imports = [
    ./flatpak.nix
    ./config.nix
  ];

  home.stateVersion = "23.05";

  programs.home-manager.enable = true;
}
