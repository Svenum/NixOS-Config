{ pkgs, lib, ... }:

{
  environment = {
    systemPackages = with pkgs; [
      solaar
      rsync
      timeshift
      nvtop
      (handbrake.overrideAttrs (_: { buildInputs = buildInputs ++ [ pkgs.nv-codec-headers ]; }))
    ];
  };

  # Gamemode
  programs.gamemode.enable = true;
}
