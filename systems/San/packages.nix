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
  nixpkgs.config.permittedInsecurePackages = [
      "electron-13.6.9"
      "nodejs-14.21.3"
      "openssl-1.1.1u"
  ];
  hardware.tuxedo-control-center.enable = true;
}
