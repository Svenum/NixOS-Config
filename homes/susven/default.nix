{ config, pkgs, ...}:

{
  home.username = "susven";
  home.homeDirectory = "/home/susven";

  xdg.userDirs.enable = true;
  xdg.userDirs.createDirectories = true;

  imports = [
    #./flatpak.nix
  ];

  home.stateVersion = "23.05";

  programs.home-manager.enable = true;
}
