{ pkgs, ... }:

{
  environment = {
    systemPackages = with pkgs; [
      solaar
      rsync
      timeshift
      nvtop
      (handbrake.override {
        stdenv = mkOverride config.stdenv { isLinux = true; };
      })
    ];
  };

  # Gamemode
  programs.gamemode.enable = true;
}
