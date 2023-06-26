{ config, pkgs, ... }:

{
  home.username = "susven";
  home.homeDirectory = "/home/susven";
 
  programs.git = {
    enable = true;
    userName = "Svenum";
    userEmail = "s.ziegler@holypenguin.net";
  };

  home.packages = with pkgs; [
    htop
  ];

  home.stateVersion = "23.05";

  programs.home-manager.enable = true;

}
