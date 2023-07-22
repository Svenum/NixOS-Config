{ pkgs, ... }:

{
  environment = {
    systemPackages = with pkgs; [
      solaar
      rsync
      timeshift
      nvtop
      (handbrake.override {
        nv-codec-headers
      };)
    ];
  };

  # Gamemode
  programs.gamemode.enable = true;
}
