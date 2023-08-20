{ pkgs, lib, ... }:

{
  environment = {
    systemPackages = with pkgs; [
      solaar
      rsync
      nvtop
    ];
  };
  # Gamemode
  programs.gamemode.enable = true;
  
  # KDEConnect
  programs.kdeconnect.enable = true;
}
