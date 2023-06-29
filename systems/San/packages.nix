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
  hardware.tuxedo-control-center.enable = true;
}
