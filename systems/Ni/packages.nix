{ pkgs, lib, ... }:

{
  environment = {
    systemPackages = with pkgs; [
      solaar
      rsync
      timeshift
      nvtop
      (handbrake.overrideAttrs (oldAttrs: rec {
        buildInputs = oldAttrs.buildInputs ++ [numactl nv-codec-headers];
      }))
    ];
  };

  # Gamemode
  programs.gamemode.enable = true;
}
