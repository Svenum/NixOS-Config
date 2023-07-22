{ pkgs, lib, ... }:

{
  environment = {
    systemPackages = with pkgs; [
      solaar
      rsync
      timeshift
      nvtop
      (handbrake.override {
        stdenv = stdenv // { isLinux = true; };
      })
    ];
  };

  # Gamemode
  programs.gamemode.enable = true;
}
