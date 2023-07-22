{ pkgs, lib, ... }:

{
  environment = {
    systemPackages = with pkgs; [
      solaar
      rsync
      timeshift
      nvtop
      (handbrake.override {
        stdenv = lib.mkOverride stdenv { isLinux = true; };
      })
    ];
  };

  # Gamemode
  programs.gamemode.enable = true;
}
