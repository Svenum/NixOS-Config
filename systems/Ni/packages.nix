{ pkgs, lib, ... }:

{
  environment = {
    systemPackages = with pkgs; [
      solaar
      rsync
      timeshift
      nvtop
      (handbrake.override {
        buildInputs = buildInputs ++ [ "nv-encodec-headers" ];
      })
    ];
  };

  # Gamemode
  programs.gamemode.enable = true;
}
