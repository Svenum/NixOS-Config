{ pkgs, ... }:

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

  # Tuxedo Control Center
  hardware.tuxedo-control-center.enable = true;
}
