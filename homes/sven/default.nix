{ config, pkgs, lib, ...}:

{
  home.username = "sven";
  home.homeDirectory = lib.mkDefault "/home/sven";

  programs.git = {
    enable = true;
    userName = "Svenum";
    userEmail = "s.ziegler@holypenguin.net";
    extraConfig = {
      safe.directory = "/etc/nixos";
    };
  };

  imports = [
    ./flatpak.nix
    ./packages.nix
  ];

  home.stateVersion = "22.11";

  programs.home-manager.enable = true;
}
