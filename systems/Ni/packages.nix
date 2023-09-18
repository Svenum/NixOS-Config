{ pkgs, lib, ... }:

#let 
#  solaar = pkgs.callPackage ../../custom-nixpkgs/solaar {};
#in
{
  environment = {
    systemPackages = with pkgs; [
      #solaar
      rsync
      nvtop
    ];
  };
  # Gamemode
  programs.gamemode.enable = true;
  
  # KDEConnect
  programs.kdeconnect.enable = true;
}
