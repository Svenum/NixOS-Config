{ pkgs, lib, ... }:

{
  environment = {
    systemPackages = with pkgs; [
      solaar
      rsync
      timeshift
      nvtop
    ];
  };

  # Configure Timeshift
  environment.etc."timeshift/timeshift.json".source = ./configs/timeshift.json;

  # Gamemode
  programs.gamemode.enable = true;
  
  # KDEConnect
  programs.kdeconnect.enable = true;
}
