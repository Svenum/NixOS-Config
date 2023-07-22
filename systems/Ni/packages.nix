{ pkgs, lib, ... }:

{
  environment = {
    systemPackages = with pkgs; [
      solaar
      rsync
      timeshift
      nvtop
      handbrake
    ];
  };

  # Gamemode
  programs.gamemode.enable = pkgs.stdenv.isLinux;
}
