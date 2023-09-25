{ pkgs, ... }:

{
  environment = {
    systemPackages = with pkgs; [
      rsync
      nvtop
      powertop
      linuxKernel.packages.linux_latest_libre.bbswitch
    ];
  };
  # Gamemode
  programs.gamemode.enable = true;
   
  # KDEConnect
  programs.kdeconnect.enable = true;

  # Tuxedo Control Center
  hardware.tuxedo-control-center.enable = true;
}
