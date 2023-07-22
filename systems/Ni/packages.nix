{ pkgs, lib, ... }:

{
  environment = {
    systemPackages = with pkgs; [
      solaar
      rsync
      timeshift
      nvtop
      (handbrake.overrideAttrs (_: { self.buildInputs = self.buildInputs ++ [numactl nv-codec-headers]; }))
    ];
  };

  # Gamemode
  programs.gamemode.enable = true;
}
