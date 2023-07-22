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
  programs.gamemode.enable = false;#pkgs.stdenv.isLinux;
}
