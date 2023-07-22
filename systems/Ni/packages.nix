{ pkgs, ... }:

{
  environment = {
    systemPackages = with pkgs; [
      solaar
      rsync
      timeshift
      nvtop
      (handbrake.override {
        pkgs.stdenv.isLinux = mkForce true;
      })
    ];
  };

  # Gamemode
  programs.gamemode.enable = true;
}
