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
  # Tuxedo Control Center
  nixpkgs.config.permittedInsecurePackages = [
    "openssl-1.1.1u"
  ];
  hardware.tuxedo-control-center.enable = true;
}
