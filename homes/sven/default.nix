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

  xdg.userDirs.enable = true;
  xdg.userDirs.createDirectories = true;

  imports = [
    #./flatpak.nix
    ./autostart.nix
    ./packages.nix
  ];
  home.stateVersion = "23.05";

  programs.home-manager.enable = true;
}
