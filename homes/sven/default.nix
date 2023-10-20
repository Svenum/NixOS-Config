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

  xdg.userDirs = {
    enable = true;
    createDirectories = true;
    extraConfig = {
      XDG_GAMES_DIR = "${config.home.homeDirectory}/Games";
      XDG_GITHUB_DIR = "${config.home.homeDirectory}/GitHub";
    };
  };

  imports = [
    ./packages.nix
    ./links.nix
  ];
  home.stateVersion = "23.05";

  programs.home-manager.enable = true;
}
