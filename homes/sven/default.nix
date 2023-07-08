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
    #./flatpak.nix
    ./packages.nix
  ];

  qt.enable = true;
  qt.style.package = (pkgs.catppuccin.override { flavour = [ "mocha"]; accents = [ "teal"];});
  qt.style.name = "catppuccin-latte-teal";

  home.stateVersion = "23.05";

  programs.home-manager.enable = true;
}
