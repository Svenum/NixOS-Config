{ pkgs, ... }:

let 
  solaar = pkgs.callPackage ../../custom-nixpkgs/solaar {};
in
{
  environment = {
    systemPackages = with pkgs; [
      solaar
      rsync
      nvtop
      powertop
    ];
  };
  # Gamemode
  programs.gamemode.enable = true;
   
  # KDEConnect
  programs.kdeconnect.enable = true;

  # Tuxedo Control Center
  hardware.tuxedo-control-center.enable = true;
}
