{ pkgs, stdenv, ... }:

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
  programs.gamemode.enable = stdenv.isLinux;
}
