{ pkgs, lib, ... }:

{
  environment = {
    systemPackages = with pkgs; [
      solaar
      rsync
      timeshift
      nvtop
      (handbrake.overrideAttrs (oldAttrs: rec {
        self.buildInputs = oldAttrs.self.buildInputs ++ [numactl nv-codec-headers];
      }))
    ];
  };

  # Gamemode
  programs.gamemode.enable = true;
}
