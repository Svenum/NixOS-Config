{ pkgs, lib, ... }:

{
  environment = {
    systemPackages = with pkgs; [
      solaar
      rsync
      timeshift
      nvtop
      (handbrake.overrideAttrs {
        self.buildInputs = self.buildInputs ++ [ pkgs.nv-codec-headers ]; 
      })
    ];
  };

  # Gamemode
  programs.gamemode.enable = true;
}
