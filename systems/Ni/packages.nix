{ pkgs, ... }:

{
  environment = {
    systemPackages = with pkgs; [
      solaar
      rsync
      timeshift
    ];
  };

  hardware.logitech.wireless.enable = true;
}
