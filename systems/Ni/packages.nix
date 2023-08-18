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

  # Gamemode
  programs.gamemode.enable = true;
  
  # KDEConnect
  programs.kdeconnect.enable = true;
}
