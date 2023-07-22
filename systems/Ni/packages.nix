{ pkgs, lib, ... }:

{
  environment = {
    systemPackages = with pkgs; [
      solaar
      rsync
      timeshift
      nvtop
      (handbrake.overrideAttrs (_: { buildInputs = self.buildInputs ++ [jansson numactl nv-codec-headers]; }))
    ];
  };

  # Gamemode
  programs.gamemode.enable = true;
}
